import AppKit
import TakkuCore
import SwiftUI

struct ProfileRow: View {
    let profile: ProviderProfile
    let isActive: Bool
    let isSelected: Bool

    var body: some View {
        HStack {
            Image(systemName: isSelected ? "pencil.circle.fill" : "circle")
                .foregroundStyle(isSelected ? Color.accentColor : .secondary)
            VStack(alignment: .leading) {
                Text(profile.displayName)
                Text(profile.model.isEmpty ? String(localized: "To be configured") : profile.model)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if isActive {
                Text("In use").font(.caption).foregroundStyle(.green)
            }
        }
    }
}

struct ProfileEditor: View {
    @Binding var profile: ProviderProfile
    let isActive: Bool
    let activate: () -> Void
    @State private var apiKey = ""
    /// Last characters of the saved key, so the user can tell which key is stored; `nil` if none.
    @State private var storedKeySuffix: String?
    @State private var status: String?
    @State private var isTesting = false
    /// The Extra parameters as typed: they reach the Profile only when valid.
    @State private var extraParameters = ""
    @State private var extraParametersProblem: String?

    var body: some View {
        Section {
            LabeledContent("Name") {
                PasteableTextField(placeholder: String(localized: "e.g. Mistral EU"), text: $profile.name)
            }
            LabeledContent("Base URL") {
                PasteableTextField(placeholder: String(localized: "e.g. https://api.mistral.ai/v1"), text: $profile.baseURL)
            }
            LabeledContent("Model") {
                PasteableTextField(placeholder: String(localized: "e.g. mistral-medium-latest"), text: $profile.model)
            }
            TextField("Max context (tokens)", value: $profile.maxContextTokens, format: .number)
            Picker("Reasoning", selection: $profile.reasoning) {
                Text("Model default").tag(ProviderProfile.ReasoningEffort?.none)
                Text("Off").tag(ProviderProfile.ReasoningEffort?.some(.off))
                Text("Low").tag(ProviderProfile.ReasoningEffort?.some(.low))
                Text("Medium").tag(ProviderProfile.ReasoningEffort?.some(.medium))
                Text("High").tag(ProviderProfile.ReasoningEffort?.some(.high))
            }
            LabeledContent("Extra parameters") {
                PasteableTextField(
                    placeholder: String(localized: "JSON, e.g. {\"reasoning_effort\": \"xhigh\"}"),
                    text: $extraParameters, isCode: true
                )
            }
            .onChange(of: extraParameters) { saveExtraParameters() }
            if let extraParametersProblem {
                Text(extraParametersProblem).foregroundStyle(.red)
            } else {
                Text("Added to every request as written; each key replaces what Takku sends for it. For what a model needs beyond the Reasoning menu: see the provider's documentation.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // The only place where the key is entered. It is saved only on Return or with the
            // button, never while typing: a stray keystroke must not replace a working key.
            LabeledContent("API key") {
                HStack {
                    PasteableTextField(
                        placeholder: storedKeySuffix.map { String(localized: "Saved in the Keychain (…\($0)) · paste here to replace it") }
                            ?? String(localized: "Paste the key here"),
                        text: $apiKey,
                        isSecure: true,
                        onSubmit: saveKey
                    )
                    if !apiKey.isEmpty {
                        Button("Save key", action: saveKey)
                    } else if storedKeySuffix != nil {
                        Button("Remove", role: .destructive) {
                            Keychain.deleteAPIKey(for: profile.id)
                            storedKeySuffix = nil
                            status = String(localized: "Key removed.")
                        }
                    }
                }
            }

            HStack {
                Button("Test connection") { Task { await test() } }
                    .disabled(isTesting || profile.baseURL.isEmpty || profile.model.isEmpty || extraParametersProblem != nil)
                if isTesting { ProgressView().controlSize(.small) }
                Spacer()
                if isActive {
                    Text("Used for Summaries").foregroundStyle(.green)
                } else {
                    Button("Use for Summaries", action: activate)
                }
            }
            if let status {
                Text(status).foregroundStyle(.secondary).textSelection(.enabled)
            }
        } header: {
            Text("Profile: \(profile.displayName)")
        } footer: {
            Text("Changes are saved as you type. The key goes to the Keychain when you press Return or Save key.")
                .foregroundStyle(.secondary)
        }
        .onAppear {
            refreshStoredKey()
            extraParameters = profile.extraParameters ?? ""
        }
    }

    /// Saved only when valid: otherwise the field shows the problem and the Profile keeps the
    /// last valid parameters.
    private func saveExtraParameters() {
        do {
            _ = try ExtraParameters.parse(extraParameters)
            let trimmed = extraParameters.trimmingCharacters(in: .whitespacesAndNewlines)
            profile.extraParameters = trimmed.isEmpty ? nil : trimmed
            extraParametersProblem = nil
        } catch {
            extraParametersProblem = error.localizedDescription
        }
    }

    private func saveKey() {
        guard !apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        do {
            try Keychain.setAPIKey(apiKey, for: profile.id)
            apiKey = ""
            refreshStoredKey()
            status = String(localized: "Key saved in the Keychain.")
        } catch {
            status = error.localizedDescription
        }
    }

    private func refreshStoredKey() {
        storedKeySuffix = Keychain.apiKey(for: profile.id).map { String($0.suffix(4)) }
    }

    private func test() async {
        isTesting = true
        defer { isTesting = false }
        do {
            let reply = try await ChatClient(profile: profile).complete([
                ChatMessage(role: .user, content: "Reply with the word OK only."),
            ])
            status = String(localized: "It works. Reply: \(String(reply.prefix(40)))")
        } catch {
            status = error.localizedDescription
        }
    }
}
