import Foundation

public struct ChatMessage: Codable, Equatable, Sendable {
    public enum Sender: String, Codable, Sendable {
        case system, user, assistant
    }

    public let role: Sender
    public let content: String

    public init(role: Sender, content: String) {
        self.role = role
        self.content = content
    }
}

/// Client for any server with an OpenAI-compatible API (`POST {baseURL}/chat/completions`):
/// remote providers and local servers such as llama.cpp or Ollama (ADR 0004).
public struct ChatClient: Sendable {
    public enum Failure: LocalizedError, Equatable {
        /// The provider answered with an error: HTTP status and message as it sent them. When it
        /// refused the request (400, 422), also what the Profile adds to it, which may be the cause.
        case http(status: Int, message: String, reasoning: ProviderProfile.ReasoningEffort? = nil, extraParameters: Bool = false)
        /// No usable text in the reply.
        case emptyReply
        /// The model stopped at the length limit: the reply is cut in half.
        case truncated

        public var errorDescription: String? {
            switch self {
            // Looked up in the app's string catalog (Bundle.main), so the app can translate them.
            case .http(let status, let message, let reasoning, let extraParameters):
                Self.withProfileSettings(
                    String(localized: "The provider answered with error \(status): \(message)"), reasoning, extraParameters
                )
            case .emptyReply:
                String(localized: "The provider returned no text.")
            case .truncated:
                String(localized: "The model's reply was cut off by the length limit.")
            }
        }

        /// The error with what the Profile sets beyond a plain request, never the Profile's name
        /// or the parameters themselves: the message also goes to the log, which *Report a
        /// problem…* includes.
        private static func withProfileSettings(
            _ error: String, _ reasoning: ProviderProfile.ReasoningEffort?, _ extraParameters: Bool
        ) -> String {
            let settings: String? = switch (reasoning, extraParameters) {
            case (let reasoning?, true):
                String(localized: "The Profile sets Reasoning: \(reasoning.displayName) and Extra parameters.")
            case (let reasoning?, false):
                String(localized: "The Profile sets Reasoning: \(reasoning.displayName).")
            case (nil, true):
                String(localized: "The Profile sets Extra parameters.")
            case (nil, false):
                nil
            }
            guard let settings else { return error }
            return error + (error.last.map { ".!?".contains($0) } == true ? " " : ". ") + settings
        }
    }

    public typealias Transport = @Sendable (URLRequest) async throws -> (Data, HTTPURLResponse)

    private let baseURL: URL
    private let apiKey: String?
    private let model: String
    private let reasoning: ProviderProfile.ReasoningEffort?
    private let extraParameters: String?
    private let transport: Transport

    public init(
        baseURL: URL, apiKey: String?, model: String, reasoning: ProviderProfile.ReasoningEffort? = nil,
        extraParameters: String? = nil, transport: @escaping Transport
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.model = model
        self.reasoning = reasoning
        self.extraParameters = extraParameters
        self.transport = transport
    }

    public func complete(_ messages: [ChatMessage]) async throws -> String {
        let extra = try ExtraParameters.parse(extraParameters ?? "")
        var request = URLRequest(url: baseURL.appending(path: "chat/completions"))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let apiKey {
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = try ExtraParameters.applying(extra, to: JSONEncoder().encode(RequestBody(
            model: model, messages: messages, reasoning: reasoning, openRouter: Self.isOpenRouter(baseURL)
        )))

        let (data, response) = try await transport(request)
        guard (200..<300).contains(response.statusCode) else {
            let refused = [400, 422].contains(response.statusCode)
            throw Failure.http(
                status: response.statusCode, message: Self.errorMessage(in: data),
                reasoning: refused ? reasoning : nil, extraParameters: refused && !extra.isEmpty
            )
        }
        let choice = (try? JSONDecoder().decode(ResponseBody.self, from: data))?.choices.first
        guard choice?.finishReason != "length" else { throw Failure.truncated }
        guard let content = choice?.message.content,
              case let reply = Self.removingThinking(content).trimmingCharacters(in: .whitespacesAndNewlines),
              !reply.isEmpty
        else {
            throw Failure.emptyReply
        }
        return reply
    }

    /// OpenRouter takes the reasoning in its own format; every other provider as OpenAI does.
    private static func isOpenRouter(_ url: URL) -> Bool {
        guard let host = url.host()?.lowercased() else { return false }
        return host == "openrouter.ai" || host.hasSuffix(".openrouter.ai")
    }

    /// Some models write their reasoning in the reply, between `<think>` tags (`<thinking>` for
    /// others), and the opening tag is sometimes missing: only what follows the last closing tag
    /// is the answer.
    private static func removingThinking(_ reply: String) -> String {
        for tag in ["</think>", "</thinking>"] {
            if let end = reply.range(of: tag, options: .backwards) {
                return String(reply[end.upperBound...])
            }
        }
        return reply
    }

    /// The error message in the OpenAI format (`{"error":{"message":…}}`), otherwise the raw text.
    private static func errorMessage(in data: Data) -> String {
        struct ErrorBody: Decodable {
            struct Detail: Decodable { let message: String }
            let error: Detail
        }
        if let body = try? JSONDecoder().decode(ErrorBody.self, from: data) {
            return body.error.message
        }
        return String(decoding: data.prefix(300), as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private struct RequestBody: Encodable {
        struct Reasoning: Encodable {
            let effort: ProviderProfile.ReasoningEffort
        }
        let model: String
        let messages: [ChatMessage]
        /// OpenRouter: `"reasoning": {"effort": "high"}`.
        let reasoning: Reasoning?
        /// Everyone else, as OpenAI: `"reasoning_effort": "high"`. Both are left out when `nil`.
        let reasoningEffort: ProviderProfile.ReasoningEffort?

        init(model: String, messages: [ChatMessage], reasoning: ProviderProfile.ReasoningEffort?, openRouter: Bool) {
            self.model = model
            self.messages = messages
            self.reasoning = openRouter ? reasoning.map(Reasoning.init) : nil
            reasoningEffort = openRouter ? nil : reasoning
        }

        enum CodingKeys: String, CodingKey {
            case model, messages, reasoning
            case reasoningEffort = "reasoning_effort"
        }
    }

    private struct ResponseBody: Decodable {
        struct Choice: Decodable {
            struct Message: Decodable {
                let content: String?

                /// Mistral, when the model reasons, sends a list of chunks instead of the text:
                /// the answer is in the `text` chunks, the reasoning in the `thinking` ones.
                struct Chunk: Decodable {
                    let type: String
                    let text: String?
                }

                enum CodingKeys: String, CodingKey { case content }

                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    if let text = try? container.decodeIfPresent(String.self, forKey: .content) {
                        content = text
                    } else if let chunks = try? container.decodeIfPresent([Chunk].self, forKey: .content) {
                        content = chunks.filter { $0.type == "text" }.compactMap(\.text).joined()
                    } else {
                        content = nil
                    }
                }
            }
            let message: Message
            let finishReason: String?

            enum CodingKeys: String, CodingKey {
                case message
                case finishReason = "finish_reason"
            }
        }
        let choices: [Choice]
    }
}
