import Foundation
import NaturalLanguage

/// Hesitations Parakeet writes out: macOS's recogniser takes them for Portuguese or German.
private let fillers: Set<String> = ["uh", "um", "uhm", "mm", "hmm", "mhm", "eh", "ehm", "ah", "oh"]

/// One word says too little about its language ("okej", "nul"): such replies are kept.
private let minimumWords = 2

/// Below this the Meeting languages together are practically ruled out. In 7 hours of real
/// Meetings in Italian and English it drops Parakeet's sentences in Slovak, German or Russian on
/// faint audio, and keeps Italian ones the recogniser mistakes for Portuguese ("Vai continua
/// Gabriele.", 0.03).
private let maximumMeetingProbability = 0.01

/// True when Parakeet wrote a sentence in a language the Meeting cannot be in (one not in
/// `meetingLanguages`): on faint or unclear audio it can switch language and make up words.
/// Whisper is held to the Meeting language and does not need this.
public func isInAnotherLanguage(_ text: String, meetingLanguages: [String]) -> Bool {
    let words = text.split { $0.isWhitespace || $0.isPunctuation && $0 != "'" }
        .map { $0.lowercased() }
        .filter { word in word.contains(where: \.isLetter) && !fillers.contains(word) }
    guard words.count >= minimumWords else { return false }
    let recognizer = NLLanguageRecognizer()
    recognizer.processString(words.joined(separator: " "))
    let hypotheses = recognizer.languageHypotheses(withMaximum: 100)
    guard let top = hypotheses.max(by: { $0.value < $1.value }), !meetingLanguages.contains(top.key.rawValue) else {
        return false
    }
    let meeting = meetingLanguages.reduce(0) { $0 + (hypotheses[NLLanguage($1)] ?? 0) }
    return meeting < maximumMeetingProbability
}
