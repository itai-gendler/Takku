import Testing
import TakkuCore

@Suite("Recognising Parakeet's sentences in a language the Meeting is not in")
struct OtherLanguageTests {
    @Test("a sentence in another language is dropped", arguments: [
        "Aber ich glaube, ich muss mit der Punkt mit der Gegenstände ab 1013.",
        "Det här kommt blockad om.",
        "Ну, что ты так должен?",
        "Maar dat is echt een beetje voor.",
    ])
    func otherLanguage(text: String) {
        #expect(isInAnotherLanguage(text, meetingLanguages: ["it", "en"]))
    }

    @Test("a sentence in a Meeting language is kept", arguments: [
        "Ciao, scusatemi davvero tanto.",
        "Let me share my screen now.",
        "Vai continua Gabriele.",
        "Io le vederei onestamente, no, no, no.",
        "O altra idea?",
    ])
    func meetingLanguage(text: String) {
        #expect(!isInAnotherLanguage(text, meetingLanguages: ["it", "en"]))
    }

    @Test("fillers do not make English look like another language", arguments: [
        "Um so um I mentioned think aloud.",
        "Uh whereas uh the implementers um actually um engaged uh and it's a very good point.",
        "okay so um",
    ])
    func fillers(text: String) {
        #expect(!isInAnotherLanguage(text, meetingLanguages: ["it", "en"]))
    }

    @Test("a single word is kept: too little to tell the language")
    func singleWord() {
        #expect(!isInAnotherLanguage("Okej.", meetingLanguages: ["it", "en"]))
        #expect(!isInAnotherLanguage("Um, andere.", meetingLanguages: ["it", "en"]))
    }

    @Test("a language ticked for the Meeting is kept")
    func tickedLanguage() {
        #expect(!isInAnotherLanguage("Aber ich glaube, ich muss mit der Punkt mit der Gegenstände ab 1013.", meetingLanguages: ["it", "de"]))
    }

    @Test("with only Italian ticked an English sentence is dropped")
    func onlyItalian() {
        #expect(isInAnotherLanguage("Let me share my screen now.", meetingLanguages: ["it"]))
    }
}
