import Foundation

/// The app Takku opens the notes of the Vault with.
public enum Editor: Equatable, Sendable {
    case obsidian
    /// Another Markdown editor, by bundle ID.
    case app(bundleID: String)
    /// The Mac's default app for Markdown, when Obsidian is not installed.
    case systemDefault

    public static let obsidianBundleID = "md.obsidian"

    /// The Editor in use for the app chosen in Settings (its bundle ID, `nil` if never chosen).
    /// A chosen app no longer installed gives way to Obsidian, as if nothing had been chosen.
    public static func resolved(chosen: String?, isInstalled: (String) -> Bool) -> Editor {
        if let chosen, chosen != obsidianBundleID, isInstalled(chosen) { return .app(bundleID: chosen) }
        return isInstalled(obsidianBundleID) ? .obsidian : .systemDefault
    }
}
