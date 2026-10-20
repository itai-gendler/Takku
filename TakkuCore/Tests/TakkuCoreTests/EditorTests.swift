import Testing
import TakkuCore

@Suite("Choosing the Editor")
struct EditorTests {
    private static let zed = "dev.zed.Zed"

    @Test("with nothing chosen the notes open in Obsidian")
    func obsidianByDefault() {
        #expect(Editor.resolved(chosen: nil, isInstalled: { _ in true }) == .obsidian)
    }

    @Test("an installed app chosen in Settings opens the notes")
    func chosenApp() {
        #expect(Editor.resolved(chosen: Self.zed, isInstalled: { _ in true }) == .app(bundleID: Self.zed))
    }

    @Test("Obsidian chosen in Settings is Obsidian, not just another app")
    func obsidianChosen() {
        #expect(Editor.resolved(chosen: Editor.obsidianBundleID, isInstalled: { _ in true }) == .obsidian)
    }

    @Test("a chosen app that is no longer installed gives way to Obsidian")
    func uninstalledApp() {
        #expect(Editor.resolved(chosen: Self.zed, isInstalled: { $0 == Editor.obsidianBundleID }) == .obsidian)
    }

    @Test("without Obsidian and without an installed choice, the Mac's default app for Markdown")
    func systemDefaultWithoutObsidian() {
        #expect(Editor.resolved(chosen: nil, isInstalled: { _ in false }) == .systemDefault)
        #expect(Editor.resolved(chosen: Self.zed, isInstalled: { _ in false }) == .systemDefault)
    }
}
