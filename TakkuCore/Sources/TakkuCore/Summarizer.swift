import Foundation

/// Writes the Summary with a Provider: in one request if the Transcript fits in the model's
/// context, otherwise summarising in blocks and merging the partial summaries.
public struct Summarizer: Sendable {
    private let client: ChatClient
    private let maxContextTokens: Int
    private let log: SummaryLog.Recorder?

    /// Below this context there is no useful room left for the Transcript after rules and reply.
    public static let minimumContextTokens = 8_192

    /// With `log`, every request and reply is also copied there.
    public init(client: ChatClient, maxContextTokens: Int, log: SummaryLog.Recorder? = nil) {
        self.client = client
        self.maxContextTokens = max(maxContextTokens, Self.minimumContextTokens)
        self.log = log
    }

    /// The model cites the Transcript times of every point; they are removed here, after the
    /// merge has used those of the partial summaries, together with any star of a marked paragraph.
    public func summarize(_ prompt: SummaryPrompt) async throws -> String {
        SummaryPrompt.removingMarks(SummaryPrompt.removingCitedTimes(try await reply(prompt)))
    }

    private func reply(_ prompt: SummaryPrompt) async throws -> String {
        if prompt.fits(maxContextTokens: maxContextTokens) {
            return try await client(.single).complete(prompt.singleRequest())
        }
        var partials = try await complete(prompt.partialRequests(maxContextTokens: maxContextTokens), as: .partial)
        // Very long Meetings: summaries are merged in groups until the final merge fits in the context.
        while !prompt.mergeFits(partials: partials, maxContextTokens: maxContextTokens) {
            let groups = prompt.groupRequests(partials: partials, maxContextTokens: maxContextTokens)
            guard groups.count < partials.count else { break }
            partials = try await complete(groups, as: .group)
        }
        return try await client(.merge).complete(prompt.mergeRequest(partials: partials))
    }

    private func complete(_ requests: [[ChatMessage]], as kind: SummaryLog.Call.Kind) async throws -> [String] {
        let client = client(kind)
        var replies: [String] = []
        for request in requests {
            replies.append(try await client.complete(request))
        }
        return replies
    }

    private func client(_ kind: SummaryLog.Call.Kind) -> ChatClient {
        log.map { client.recording(into: $0, as: kind) } ?? client
    }
}
