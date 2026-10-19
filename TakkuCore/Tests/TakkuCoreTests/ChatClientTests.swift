import Foundation
import Testing
import TakkuCore

/// Records requests and returns prepared replies: no network calls.
final class StubTransport: @unchecked Sendable {
    private(set) var requests: [URLRequest] = []
    private let respond: (Int) -> (status: Int, body: String)

    init(status: Int = 200, body: String) {
        respond = { _ in (status, body) }
    }

    /// `reply(n)` is the text of the reply to request number `n` (from 0).
    init(reply: @escaping (Int) -> String) {
        respond = { index in
            let content = String(data: try! JSONEncoder().encode(reply(index)), encoding: .utf8)!
            return (200, #"{"choices":[{"message":{"role":"assistant","content":"# + content + "}}]}")
        }
    }

    func send(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (status, body) = respond(requests.count)
        requests.append(request)
        let response = HTTPURLResponse(url: request.url!, statusCode: status, httpVersion: nil, headerFields: nil)!
        return (Data(body.utf8), response)
    }

    /// The text of the `role` message of request number `index`.
    func message(_ index: Int, _ role: String) -> String? {
        guard let body = requests[index].httpBody,
              let json = try? JSONSerialization.jsonObject(with: body) as? [String: Any],
              let messages = json["messages"] as? [[String: String]]
        else { return nil }
        return messages.first { $0["role"] == role }?["content"]
    }
}

@Suite("OpenAI-compatible client")
struct ChatClientTests {
    let messages = [ChatMessage(role: .system, content: "You are Takku."), ChatMessage(role: .user, content: "Summarise.")]

    @Test("the request goes to chat/completions with model, messages and key")
    func request() async throws {
        let stub = StubTransport(body: #"{"choices":[{"message":{"role":"assistant","content":"Ok."}}]}"#)
        let client = ChatClient(
            baseURL: URL(string: "https://openrouter.ai/api/v1")!, apiKey: "sk-test", model: "openai/gpt-6-luna",
            transport: stub.send
        )

        _ = try await client.complete(messages)

        let request = try #require(stub.requests.first)
        #expect(request.url?.absoluteString == "https://openrouter.ai/api/v1/chat/completions")
        #expect(request.httpMethod == "POST")
        #expect(request.value(forHTTPHeaderField: "Authorization") == "Bearer sk-test")
        #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
        let body = try #require(JSONSerialization.jsonObject(with: request.httpBody ?? Data()) as? [String: Any])
        #expect(body["model"] as? String == "openai/gpt-6-luna")
        let sent = try #require(body["messages"] as? [[String: String]])
        #expect(sent == [["role": "system", "content": "You are Takku."], ["role": "user", "content": "Summarise."]])
    }

    @Test("OpenRouter gets the reasoning as an object, every other provider as reasoning_effort", arguments: [
        ("https://openrouter.ai/api/v1", ProviderProfile.ReasoningEffort.high, #"{"effort":"high"}"# as String?, nil as String?),
        ("https://openrouter.ai/api/v1", .off, #"{"effort":"none"}"#, nil),
        ("https://api.eurouter.ai/api/v1", .low, nil, "low"),
        ("https://api.mistral.ai/v1", .off, nil, "none"),
        ("http://localhost:8080/v1", .medium, nil, "medium"),
    ])
    func reasoning(baseURL: String, effort: ProviderProfile.ReasoningEffort, object: String?, field: String?) async throws {
        let stub = StubTransport(body: #"{"choices":[{"message":{"role":"assistant","content":"Ok."}}]}"#)
        let client = ChatClient(baseURL: URL(string: baseURL)!, apiKey: nil, model: "m", reasoning: effort, transport: stub.send)

        _ = try await client.complete(messages)

        let body = try #require(JSONSerialization.jsonObject(with: stub.requests.first?.httpBody ?? Data()) as? [String: Any])
        let sentObject = try body["reasoning"].map { String(decoding: try JSONSerialization.data(withJSONObject: $0), as: UTF8.self) }
        #expect(sentObject == object)
        #expect(body["reasoning_effort"] as? String == field)
    }

    @Test("without a reasoning level the request carries neither field", arguments: ["https://openrouter.ai/api/v1", "https://api.mistral.ai/v1"])
    func noReasoning(baseURL: String) async throws {
        let stub = StubTransport(body: #"{"choices":[{"message":{"role":"assistant","content":"Ok."}}]}"#)
        let client = ChatClient(baseURL: URL(string: baseURL)!, apiKey: nil, model: "m", transport: stub.send)

        _ = try await client.complete(messages)

        let body = try #require(JSONSerialization.jsonObject(with: stub.requests.first?.httpBody ?? Data()) as? [String: Any])
        #expect(body["reasoning"] == nil)
        #expect(body["reasoning_effort"] == nil)
    }

    @Test("a reply in chunks (Mistral reasoning) gives the text chunks, not the thinking")
    func chunks() async throws {
        let stub = StubTransport(body: #"""
            {"choices":[{"message":{"role":"assistant","content":[
              {"type":"thinking","thinking":[{"type":"text","text":"The user wants a summary."}]},
              {"type":"text","text":"### Topics\n"},{"type":"text","text":"All good."}
            ]}}]}
            """#)
        let client = ChatClient(baseURL: URL(string: "https://api.mistral.ai/v1")!, apiKey: nil, model: "m", transport: stub.send)

        #expect(try await client.complete(messages) == "### Topics\nAll good.")
    }

    @Test("reasoning written in the reply between think tags is not part of it", arguments: [
        "<think>\nThe user wants a summary.\n</think>\n\n### Topics\nAll good.",
        "The user wants a summary.\n</think>\n### Topics\nAll good.",
        "<thinking>Plan the sections.</thinking>### Topics\nAll good.",
    ])
    func thinkTags(content: String) async throws {
        let reply = String(data: try JSONEncoder().encode(content), encoding: .utf8)!
        let stub = StubTransport(body: #"{"choices":[{"message":{"role":"assistant","content":"# + reply + "}}]}")
        let client = ChatClient(baseURL: URL(string: "https://api.scaleway.ai/v1")!, apiKey: nil, model: "m", transport: stub.send)

        #expect(try await client.complete(messages) == "### Topics\nAll good.")
    }

    @Test("a reply that is only reasoning is an empty reply")
    func onlyThinking() async {
        let stub = StubTransport(body: #"{"choices":[{"message":{"role":"assistant","content":"<think>Hmm.</think>\n"}}]}"#)
        let client = ChatClient(baseURL: URL(string: "https://x.example/v1")!, apiKey: nil, model: "m", transport: stub.send)

        await #expect(throws: ChatClient.Failure.emptyReply) {
            try await client.complete(messages)
        }
    }

    @Test("without a key (local server) there is no Authorization header; the reply is trimmed")
    func localServer() async throws {
        let stub = StubTransport(body: #"{"choices":[{"message":{"role":"assistant","content":"\n  ### Topics\nAll good.\n\n"}}]}"#)
        let client = ChatClient(
            baseURL: URL(string: "http://localhost:8080/v1/")!, apiKey: nil, model: "locale", transport: stub.send
        )

        let reply = try await client.complete(messages)

        #expect(reply == "### Topics\nAll good.")
        #expect(stub.requests.first?.url?.absoluteString == "http://localhost:8080/v1/chat/completions")
        #expect(stub.requests.first?.value(forHTTPHeaderField: "Authorization") == nil)
    }

    @Test("an HTTP error carries the status and the provider's message")
    func httpError() async {
        let stub = StubTransport(status: 401, body: #"{"error":{"message":"No auth credentials found","code":401}}"#)
        let client = ChatClient(baseURL: URL(string: "https://x.example/v1")!, apiKey: "wrong", model: "m", transport: stub.send)

        await #expect(throws: ChatClient.Failure.http(status: 401, message: "No auth credentials found")) {
            try await client.complete(messages)
        }
    }

    @Test("an HTTP error without a JSON body carries the raw text")
    func httpErrorWithoutJSON() async {
        let stub = StubTransport(status: 502, body: "Bad Gateway")
        let client = ChatClient(baseURL: URL(string: "https://x.example/v1")!, apiKey: nil, model: "m", transport: stub.send)

        await #expect(throws: ChatClient.Failure.http(status: 502, message: "Bad Gateway")) {
            try await client.complete(messages)
        }
    }

    @Test("a reply without text is an error, not an empty Summary", arguments: [
        #"{"choices":[{"message":{"role":"assistant","content":"   "}}]}"#,
        #"{"choices":[{"message":{"role":"assistant","content":null}}]}"#,
        #"{"choices":[]}"#,
        "not JSON",
    ])
    func emptyReply(body: String) async {
        let stub = StubTransport(body: body)
        let client = ChatClient(baseURL: URL(string: "https://x.example/v1")!, apiKey: nil, model: "m", transport: stub.send)

        await #expect(throws: ChatClient.Failure.emptyReply) {
            try await client.complete(messages)
        }
    }

    @Test("a reply cut off by the length limit is an error, not half a Summary")
    func truncated() async {
        let stub = StubTransport(body: ####"{"choices":[{"message":{"role":"assistant","content":"### Topics\nThe budget"},"finish_reason":"length"}]}"####)
        let client = ChatClient(baseURL: URL(string: "https://x.example/v1")!, apiKey: nil, model: "m", transport: stub.send)

        await #expect(throws: ChatClient.Failure.truncated) {
            try await client.complete(messages)
        }
    }
}
