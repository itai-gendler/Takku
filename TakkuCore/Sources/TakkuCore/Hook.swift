import Foundation

/// The user's executable that Takku runs when a Meeting completes Processing, with the paths of
/// the Meeting note and of the Transcript (ADR 0007). What is decided here: the `PATH` it gets,
/// the command to rerun it by hand and its log.
public enum Hook {
    public static let timeout: Duration = .seconds(300)
    /// Past this size the log keeps only its last half.
    public static let logLimit = 1_000_000

    public enum Outcome: Equatable, Sendable {
        case exited(Int32)
        case timedOut
        /// The file exists but cannot be run: usually a forgotten `chmod +x`.
        case notExecutable

        public var failed: Bool { self != .exited(0) }
    }

    /// Homebrew's folders first, as in the Terminal: an app started from the Dock or at login
    /// gets only the system ones, and the script would not find what the user installed.
    public static func path(adding current: String?) -> String {
        let existing = current.map { $0.split(separator: ":").map(String.init) } ?? []
        let added = ["/opt/homebrew/bin", "/usr/local/bin"].filter { !existing.contains($0) }
        return (added + existing).joined(separator: ":")
    }

    /// The command that runs the Hook again from the Terminal, every part quoted for the shell.
    public static func command(executable: String, arguments: [String]) -> String {
        ([executable] + arguments).map { "'" + $0.replacingOccurrences(of: "'", with: #"'\''"#) + "'" }
            .joined(separator: " ")
    }

    public static func logEntry(
        date: Date, timeZone: TimeZone = .current, noteName: String, command: String, outcome: Outcome, output: String
    ) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = switch outcome {
        case .exited(let code): "exit code \(code)"
        case .timedOut: "terminated after \(timeout.components.seconds / 60) minutes"
        case .notExecutable: "not executable: run `chmod +x ~/.takku/hooks/after-processing`"
        }
        let body = output.isEmpty || output.hasSuffix("\n") ? output : output + "\n"
        return "── \(formatter.string(from: date)) · \(noteName)\n$ \(command)\n\(body)→ \(result)\n\n"
    }

    /// The log as it is or, past `limit` bytes, its last half starting from a whole line.
    public static func trimmedLog(_ log: String, limit: Int = logLimit) -> String {
        guard log.utf8.count > limit else { return log }
        let tail = String(decoding: log.utf8.suffix(limit / 2), as: UTF8.self)
        guard let firstLineEnd = tail.firstIndex(of: "\n") else { return tail }
        return String(tail[tail.index(after: firstLineEnd)...])
    }
}
