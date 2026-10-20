import AppKit
import SwiftUI
import TakkuCore

/// The Editor row of the Vault section: Obsidian first if installed, then the Markdown editors on
/// this Mac. Choosing Obsidian clears the choice, so it is the default again.
struct EditorRow: View {
    @AppStorage(AppSettings.editorKey) private var chosen = ""
    /// Read when the row appears: apps come and go.
    @State private var editors = TextEditors.none

    var body: some View {
        LabeledContent("Editor") {
            Menu {
                if let obsidian = Editor.appURL(Editor.obsidianBundleID) {
                    Button { chosen = "" } label: { AppLabel(app: obsidian) }
                    if !others.isEmpty { Divider() }
                }
                ForEach(others, id: \.self) { app in
                    Button {
                        choose(app)
                    } label: {
                        AppLabel(app: app, isDefault: app == editors.defaultApp)
                    }
                }
            } label: {
                currentLabel
            }
            .fixedSize()
        }
        .onAppear { editors = .markdown() }
        if isChosenMissing {
            Text("The chosen editor is no longer installed: notes open with the one shown above.")
                .foregroundStyle(.secondary)
        }
    }

    /// Obsidian saves as you type; another editor may hold Personal notes the Summary never sees,
    /// so a notification says so once, when it is chosen.
    private func choose(_ app: URL) {
        let bundleID = Bundle(url: app)?.bundleIdentifier ?? ""
        guard bundleID != chosen else { return }
        chosen = bundleID
        Notifications.shared.notify(
            title: String(localized: "Turn on autosave in \(TextEditors.name(of: app))"),
            body: String(localized: "Takku reads your Personal notes from disk: those not yet saved do not reach the Summary."),
            note: nil
        )
    }

    private var editor: Editor {
        Editor.resolved(chosen: chosen)
    }

    @ViewBuilder
    private var currentLabel: some View {
        switch editor {
        case .obsidian:
            Text(verbatim: "Obsidian")
        case .app(let bundleID):
            Text(verbatim: Editor.appURL(bundleID).map(TextEditors.name(of:)) ?? bundleID)
        case .systemDefault:
            if let app = editors.defaultApp {
                Text("\(TextEditors.name(of: app)) (default)")
            } else {
                Text("Default app")
            }
        }
    }

    /// The Markdown editors but Obsidian, which has its own item.
    private var others: [URL] {
        editors.apps.filter { Bundle(url: $0)?.bundleIdentifier != Editor.obsidianBundleID }
    }

    private var isChosenMissing: Bool {
        !chosen.isEmpty && chosen != Editor.obsidianBundleID && Editor.appURL(chosen) == nil
    }
}
