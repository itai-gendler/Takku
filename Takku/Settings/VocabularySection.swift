import AppKit
import TakkuCore
import SwiftUI

/// The Vocabulary: the terms Takku read from the file, so a line written wrong shows by not
/// being there, and the editors to change it with.
struct VocabularySection: View {
    @State private var terms: [String] = []
    @State private var status: String?
    /// Read when the section appears: apps come and go.
    @State private var editors = TextEditors.none

    var body: some View {
        Section {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    switch terms.count {
                    case 0: Text("No terms yet")
                    case 1: Text("1 term")
                    default: Text("\(terms.count) terms")
                    }
                    if let preview {
                        Text(preview)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
                Spacer()
                EditWithMenu(title: "Edit Vocabulary With", editors: editors, edit: edit)
            }
            if let status {
                Text(status).foregroundStyle(.secondary)
            }
        } header: {
            Text("Vocabulary")
        } footer: {
            Text("In ~/.takku/vocabulary.md, one per line: `- Scaleway = scale uai | our EU cloud provider`. The Summary uses them; the variants you list are fixed in the Transcript.")
                .foregroundStyle(.secondary)
        }
        .onAppear {
            editors = .markdown()
            reload()
        }
        // Back from the editor after changing the file.
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in reload() }
    }

    /// The first terms, in the file's order, and how many are left out.
    private var preview: String? {
        let shown = terms.prefix(Self.previewCount).joined(separator: ", ")
        guard !shown.isEmpty else { return nil }
        let more = terms.count - Self.previewCount
        return more > 0 ? String(localized: "\(shown) and \(more) more") : shown
    }

    private static let previewCount = 4

    private func reload() {
        terms = TakkuFolder.vocabulary().entries.map(\.term)
    }

    private func edit(with app: URL) {
        do {
            try TakkuFolder.ensureVocabularyFile()
            TextEditors.open(TakkuFolder.vocabularyURL, with: app)
            status = nil
        } catch {
            status = error.localizedDescription
        }
        reload()
    }
}
