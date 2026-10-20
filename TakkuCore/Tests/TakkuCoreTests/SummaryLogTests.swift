import Foundation
import Testing
import TakkuCore

@Suite("Summary log")
struct SummaryLogTests {
    let template = Template(fileName: "Notes", content: "### Topics\n### Next steps")
    let rome = TimeZone(identifier: "Europe/Rome")!
    let profile = ProviderProfile(
        name: "Openrouter", baseURL: "https://openrouter.ai/api/v1", model: "anthropic/claude-haiku-5.5", maxContextTokens: 128_000
    )

    func transcript(paragraphs count: Int) -> Transcript {
        Transcript(utterances: (0..<count).map { index in
            Utterance(
                track: index.isMultiple(of: 2) ? .others : .me,
                start: Double(index * 20), end: Double(index * 20 + 15),
                text: "Paragraph \(index): " + String(repeating: "words from the meeting ", count: 13)
            )
        })
    }

    func client(_ stub: StubTransport) -> ChatClient {
        ChatClient(baseURL: URL(string: "https://x.example/v1")!, apiKey: "secret-key", model: "m", transport: stub.send)
    }

    func entry(error: String? = nil, calls: [SummaryLog.Call]) -> SummaryLog.Entry {
        SummaryLog.Entry(
            takkuID: UUID(uuidString: "4559E090-EDF8-4272-A8B6-1EE25C308FB3")!,
            meetingNote: "2026-10-20 1722 - Budget review", meetingStartedAt: Date(timeIntervalSince1970: 1_792_509_720),
            template: "Notes", profile: profile, error: error, calls: calls,
            writtenAt: Date(timeIntervalSince1970: 1_792_513_380)
        )
    }

    @Test("a Summary in one request leaves one call, with the body as sent and the reply as received")
    func single() async throws {
        let stub = StubTransport { _ in "### Topics\nAll good." }
        let log = SummaryLog.Recorder()
        let prompt = SummaryPrompt(template: template, personalNotes: "", transcript: transcript(paragraphs: 6), meetingLanguage: "it")

        _ = try await Summarizer(client: client(stub), maxContextTokens: 32_000, log: log).summarize(prompt)

        let calls = await log.calls
        #expect(calls.map(\.kind) == [.single])
        #expect(calls[0].request == stub.requests[0].httpBody)
        #expect(String(decoding: try #require(calls[0].response), as: UTF8.self).contains("All good."))
        #expect(calls[0].status == 200)
        #expect(calls[0].error == nil)
    }

    @Test("a Summary in blocks leaves the partials and the merge, in order")
    func blocks() async throws {
        let stub = StubTransport { index in "summary \(index + 1)" }
        let log = SummaryLog.Recorder()
        let prompt = SummaryPrompt(template: template, personalNotes: "", transcript: transcript(paragraphs: 40), meetingLanguage: "it")

        _ = try await Summarizer(client: client(stub), maxContextTokens: 8_192, log: log).summarize(prompt)

        let kinds = await log.calls.map(\.kind)
        #expect(kinds.count == stub.requests.count)
        #expect(kinds.last == .merge)
        #expect(kinds.dropLast().allSatisfy { $0 == .partial })
    }

    @Test("a request that fails without a reply is in the log with its error")
    func failed() async throws {
        let log = SummaryLog.Recorder()
        let client = ChatClient(
            baseURL: URL(string: "https://x.example/v1")!, apiKey: nil, model: "m",
            transport: { _ in throw URLError(.timedOut) }
        ).recording(into: log, as: .title)

        await #expect(throws: URLError.self) { try await client.complete([ChatMessage(role: .user, content: "Title?")]) }

        let call = try #require(await log.calls.first)
        #expect(call.kind == .title)
        #expect(call.response == nil)
        #expect(call.status == nil)
        #expect(call.error != nil)
    }

    @Test("an error reply is in the log as the provider sent it, not cut at 300 characters")
    func errorReply() async throws {
        let message = String(repeating: "x", count: 500)
        let stub = StubTransport(status: 400, body: #"{"error":{"message":""# + message + #""}}"#)
        let log = SummaryLog.Recorder()

        await #expect(throws: ChatClient.Failure.self) {
            try await client(stub).recording(into: log, as: .single).complete([ChatMessage(role: .user, content: "Hi")])
        }

        let call = try #require(await log.calls.first)
        #expect(call.status == 400)
        #expect(String(decoding: try #require(call.response), as: UTF8.self).contains(message))
    }

    @Test("without a log the Summary sends the same requests")
    func withoutLog() async throws {
        let stub = StubTransport { _ in "ok" }
        let prompt = SummaryPrompt(template: template, personalNotes: "", transcript: transcript(paragraphs: 6), meetingLanguage: "it")

        let summary = try await Summarizer(client: client(stub), maxContextTokens: 32_000).summarize(prompt)

        #expect(summary == "ok")
        #expect(stub.requests.count == 1)
    }

    @Test("the file is named after when, the Template and the model without the provider's prefix")
    func fileName() {
        #expect(entry(calls: []).fileName(timeZone: rome) == "2026-10-20 1823 - Notes - claude-haiku-5.5")
    }

    @Test("the JSON has the Meeting and the Profile without its address, then the calls with their bodies")
    func json() throws {
        let request = Data(#"{"model":"anthropic/claude-haiku-5.5","messages":[{"role":"user","content":"Summarise"}]}"#.utf8)
        let calls = [
            SummaryLog.Call(
                kind: .single, request: request, response: Data(#"{"choices":[]}"#.utf8), status: 200, seconds: 47.234, error: nil
            ),
            SummaryLog.Call(kind: .title, request: request, response: Data("Bad gateway".utf8), status: 502, seconds: 1, error: nil),
        ]

        let data = try entry(error: "The provider answered with error 502", calls: calls).json(timeZone: rome)
        let text = String(decoding: data, as: UTF8.self)
        let object = try #require(try JSONSerialization.jsonObject(with: data) as? [String: Any])
        let about = try #require(object["about"] as? [String: Any])
        let sent = try #require(object["calls"] as? [[String: Any]])

        #expect(about["comment"] as? String == "")
        #expect(text.range(of: "\"comment\"")!.lowerBound < text.range(of: "\"takku_id\"")!.lowerBound)
        #expect(about["takku_id"] as? String == "4559E090-EDF8-4272-A8B6-1EE25C308FB3")
        #expect(about["meeting_note"] as? String == "2026-10-20 1722 - Budget review")
        #expect(about["meeting_started_at"] as? String == "2026-10-20T17:22:00+02:00")
        #expect(about["template"] as? String == "Notes")
        #expect(about["profile"] as? String == "Openrouter")
        #expect(about["place"] as? String == "remote")
        #expect(about["model"] as? String == "anthropic/claude-haiku-5.5")
        #expect(about["error"] as? String == "The provider answered with error 502")
        #expect(!text.contains("openrouter.ai"))
        #expect(text.range(of: "\"about\"")!.lowerBound < text.range(of: "\"calls\"")!.lowerBound)

        #expect(sent.map { $0["kind"] as? String } == ["single", "title"])
        #expect(sent[0]["seconds"] as? Double == 47.2)
        #expect((sent[0]["request"] as? [String: Any])?["model"] as? String == "anthropic/claude-haiku-5.5")
        #expect(sent[0]["response"] is [String: Any])
        #expect(sent[1]["response"] as? String == "Bad gateway")
        #expect(sent[1]["status"] as? Int == 502)
    }

    @Test("a Summary that was written has no error in the JSON")
    func noError() throws {
        let object = try JSONSerialization.jsonObject(with: entry(calls: []).json(timeZone: rome)) as? [String: Any]
        #expect((object?["about"] as? [String: Any])?.keys.contains("error") == false)
    }

    @Test("past the limit the oldest entries go, the newest stays even when it alone is over")
    func limit() {
        let now = Date(timeIntervalSince1970: 1_792_513_380)
        func stored(_ name: String, _ bytes: Int, hoursAgo: Double) -> SummaryLog.StoredEntry {
            SummaryLog.StoredEntry(url: URL(filePath: "/log/\(name).json"), bytes: bytes, writtenAt: now.addingTimeInterval(-hoursAgo * 3_600))
        }

        let oldest = stored("oldest", 400, hoursAgo: 30)
        let older = stored("older", 400, hoursAgo: 20)
        let recent = stored("recent", 400, hoursAgo: 10)
        let newest = stored("newest", 400, hoursAgo: 0)
        #expect(Set(SummaryLog.overLimit([older, newest, oldest, recent], limit: 1_000)) == [older.url, oldest.url])
        #expect(SummaryLog.overLimit([older, newest, oldest, recent], limit: 1_600).isEmpty)

        let huge = stored("huge", 2_000, hoursAgo: 0)
        #expect(SummaryLog.overLimit([huge, oldest], limit: 1_000) == [oldest.url])
    }
}
