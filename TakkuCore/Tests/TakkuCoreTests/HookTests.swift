import Foundation
import Testing
import TakkuCore

@Suite("Hook")
struct HookTests {
    @Test("Homebrew's folders come before the PATH an app gets from the Dock, without duplicates")
    func path() {
        #expect(Hook.path(adding: "/usr/bin:/bin:/usr/sbin:/sbin") == "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin")
        #expect(Hook.path(adding: "/opt/homebrew/bin:/usr/bin") == "/usr/local/bin:/opt/homebrew/bin:/usr/bin")
        #expect(Hook.path(adding: nil) == "/opt/homebrew/bin:/usr/local/bin")
    }

    @Test("the command to rerun by hand quotes every path for the shell")
    func command() {
        let command = Hook.command(
            executable: "/Users/mario/.takku/hooks/after-processing",
            arguments: ["/Vault/Meetings/2026-10-14 1430 - Mario's sync.md", "/Vault/Meetings/Transcripts/a.md"]
        )
        #expect(command == #"'/Users/mario/.takku/hooks/after-processing' '/Vault/Meetings/2026-10-14 1430 - Mario'\''s sync.md' '/Vault/Meetings/Transcripts/a.md'"#)
    }

    @Test("a log entry has the date, the note, the command, the output and the outcome")
    func logEntry() {
        let entry = Hook.logEntry(
            date: Date(timeIntervalSince1970: 1_791_117_000), timeZone: TimeZone(identifier: "Europe/Rome")!,
            noteName: "2026-10-04 1430 - Weekly sync", command: "'hook' 'note.md' 't.md'",
            outcome: .exited(1), output: "Notion: 401 Unauthorized\n"
        )
        #expect(entry == """
            ── 2026-10-04 14:30:00 · 2026-10-04 1430 - Weekly sync
            $ 'hook' 'note.md' 't.md'
            Notion: 401 Unauthorized
            → exit code 1


            """)
    }

    @Test("a timeout and a file that is not executable say so, with what to do")
    func failedOutcomes() {
        func entry(_ outcome: Hook.Outcome) -> String {
            Hook.logEntry(
                date: Date(timeIntervalSince1970: 0), timeZone: TimeZone(identifier: "UTC")!,
                noteName: "Meeting", command: "'hook'", outcome: outcome, output: ""
            )
        }
        #expect(entry(.timedOut).contains("→ terminated after 5 minutes"))
        #expect(entry(.notExecutable).contains("→ not executable: run `chmod +x ~/.takku/hooks/after-processing`"))
        #expect(Hook.Outcome.exited(0).failed == false)
        #expect(Hook.Outcome.exited(2).failed && Hook.Outcome.timedOut.failed && Hook.Outcome.notExecutable.failed)
    }

    @Test("past the limit the log keeps the last half, from the start of a line")
    func trimmedLog() {
        let short = "one\ntwo\n"
        #expect(Hook.trimmedLog(short, limit: 100) == short)

        let log = (1...20).map { "line \($0)" }.joined(separator: "\n") + "\n"
        let trimmed = Hook.trimmedLog(log, limit: 100)
        #expect(trimmed.utf8.count <= 50)
        #expect(trimmed.hasPrefix("line "))
        #expect(trimmed.hasSuffix("line 20\n"))
    }
}
