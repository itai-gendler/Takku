import AppKit
import TakkuCore

/// The Editor among the apps installed on this Mac.
extension Editor {
    /// The Editor chosen in Settings, read at every use: the user may change it or uninstall the
    /// app at any time.
    static var current: Editor {
        resolved(chosen: AppSettings.chosenEditor)
    }

    /// `chosen` as saved in Settings: a bundle ID, empty if never chosen.
    static func resolved(chosen: String?) -> Editor {
        resolved(chosen: chosen.flatMap { $0.isEmpty ? nil : $0 }, isInstalled: { appURL($0) != nil })
    }

    static func appURL(_ bundleID: String) -> URL? {
        NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID)
    }
}
