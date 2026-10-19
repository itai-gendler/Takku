import AppKit
import SwiftUI

/// Text field where ⌘V, ⌘C, ⌘X, ⌘A and ⌘Z always work. Apps that live only in the menu bar
/// have no Edit menu, and without it SwiftUI fields ignore those shortcuts.
struct PasteableTextField: NSViewRepresentable {
    let placeholder: String
    @Binding var text: String
    var isSecure = false
    /// For code such as JSON: monospaced, left-aligned, no smart quotes or dashes.
    var isCode = false
    /// Called on Return.
    var onSubmit: () -> Void = {}

    func makeNSView(context: Context) -> NSTextField {
        let field: NSTextField = isSecure ? ShortcutSecureTextField() : ShortcutTextField()
        field.placeholderString = placeholder
        field.delegate = context.coordinator
        // Same look as SwiftUI fields in a grouped Form: borderless, right-aligned.
        field.isBordered = false
        field.isBezeled = false
        field.drawsBackground = false
        field.focusRingType = .none
        field.alignment = isCode ? .left : .right
        if isCode { field.font = .monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .regular) }
        field.lineBreakMode = .byTruncatingTail
        field.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return field
    }

    func updateNSView(_ field: NSTextField, context: Context) {
        if field.stringValue != text { field.stringValue = text }
        field.placeholderString = placeholder
    }

    func makeCoordinator() -> Coordinator { Coordinator(text: $text, isCode: isCode, onSubmit: onSubmit) }

    final class Coordinator: NSObject, NSTextFieldDelegate {
        let text: Binding<String>
        let isCode: Bool
        let onSubmit: () -> Void
        init(text: Binding<String>, isCode: Bool, onSubmit: @escaping () -> Void) {
            self.text = text
            self.isCode = isCode
            self.onSubmit = onSubmit
        }

        // The field editor is shared by every field of the window: set it each time editing starts.
        func control(_ control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
            if let editor = fieldEditor as? NSTextView {
                // With the system's smart quotes, a typed " becomes “ and the JSON is no longer valid.
                // Other fields keep the user's system settings.
                editor.isAutomaticQuoteSubstitutionEnabled = !isCode && NSSpellChecker.isAutomaticQuoteSubstitutionEnabled
                editor.isAutomaticDashSubstitutionEnabled = !isCode && NSSpellChecker.isAutomaticDashSubstitutionEnabled
                editor.isAutomaticTextReplacementEnabled = !isCode && NSSpellChecker.isAutomaticTextReplacementEnabled
            }
            return true
        }

        func controlTextDidChange(_ notification: Notification) {
            guard let field = notification.object as? NSTextField else { return }
            text.wrappedValue = field.stringValue
        }

        func control(_ control: NSControl, textView: NSTextView, doCommandBy selector: Selector) -> Bool {
            guard selector == #selector(NSResponder.insertNewline(_:)) else { return false }
            text.wrappedValue = control.stringValue
            onSubmit()
            return true
        }
    }
}

/// Forwards the editing shortcuts to the field editor, in place of the missing Edit menu.
@MainActor
private func handleEditingShortcut(_ event: NSEvent, in field: NSTextField) -> Bool {
    guard event.modifierFlags.intersection(.deviceIndependentFlagsMask) == .command,
          let key = event.charactersIgnoringModifiers?.lowercased(),
          let editor = field.currentEditor()
    else { return false }
    switch key {
    case "v": editor.paste(nil)
    case "c": editor.copy(nil)
    case "x": editor.cut(nil)
    case "a": editor.selectAll(nil)
    case "z": editor.undoManager?.undo()
    default: return false
    }
    return true
}

private final class ShortcutTextField: NSTextField {
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        handleEditingShortcut(event, in: self) || super.performKeyEquivalent(with: event)
    }
}

private final class ShortcutSecureTextField: NSSecureTextField {
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        handleEditingShortcut(event, in: self) || super.performKeyEquivalent(with: event)
    }
}
