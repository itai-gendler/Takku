import AppKit
import SwiftUI

/// The window shown at launch while no Vault is chosen (the first launch, in practice): the steps
/// to do before the first Meeting, so that no prompt or download interrupts the first call.
/// Each step can be done later in Settings; the menu reopens it with *Set up Takku…*.
struct WelcomeView: View {
    static let windowID = "welcome"

    let controller: MeetingController
    @Environment(\.openSettings) private var openSettings
    @Environment(\.dismissWindow) private var dismissWindow
    @AppStorage(AppSettings.vaultPathKey) private var vaultPath = ""
    @State private var microphoneAllowed = AudioPermissions.microphoneAllowed
    @State private var permissionsAsked = false
    @State private var isPreparingModel = false
    @State private var modelError: String?

    var body: some View {
        Form {
            Section {
                Text("Takku records your meetings, transcribes them on this Mac and writes the notes into Obsidian. A few steps before the first one:")
                    .fixedSize(horizontal: false, vertical: true)
            } header: {
                AppIdentity().frame(maxWidth: .infinity).padding(.bottom, 8)
            }

            Section {
                Text("One note per meeting goes into its Meetings folder. Any folder works.")
                    .foregroundStyle(.secondary)
                LabeledContent("Folder") {
                    HStack {
                        Text(vaultPath.isEmpty ? String(localized: "None") : vaultPath)
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .foregroundStyle(vaultPath.isEmpty ? .secondary : .primary)
                        Button("Choose…") { _ = Vault.choose() }
                    }
                }
            } header: {
                Step(number: 1, title: "Obsidian vault", isDone: !vaultPath.isEmpty)
            }

            Section {
                Text("Takku records your voice and the call. macOS asks once for each: choose Allow.")
                    .foregroundStyle(.secondary)
                HStack {
                    Button("Allow microphone and system audio") {
                        Task {
                            await AudioPermissions.request()
                            microphoneAllowed = AudioPermissions.microphoneAllowed
                            permissionsAsked = true
                        }
                    }
                    .disabled(permissionsAsked)
                    Spacer()
                }
                if permissionsAsked && !microphoneAllowed {
                    HStack {
                        Text("The microphone is not allowed.").foregroundStyle(.secondary)
                        Spacer()
                        Button("Open System Settings") { controller.openMicrophoneSettings() }
                    }
                }
                if permissionsAsked {
                    HStack {
                        Text("If you chose Don't Allow for the system audio, turn Takku on in Screen & System Audio Recording.")
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Button("Open System Settings") { AudioPermissions.openSystemAudioSettings() }
                    }
                }
            } header: {
                Step(number: 2, title: "Microphone and system audio", isDone: permissionsAsked && microphoneAllowed)
            }

            Section {
                let model = TranscriptionModel.selected
                Text("\(model.name), \(model.downloadMB) MB, downloaded once and prepared for this Mac. It takes a few minutes: you can go on meanwhile.")
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    Button("Download and prepare") {
                        Task {
                            isPreparingModel = true
                            modelError = nil
                            do {
                                try await controller.prepareTranscriptionModel()
                            } catch {
                                modelError = error.localizedDescription
                            }
                            isPreparingModel = false
                        }
                    }
                    .disabled(isPreparingModel || controller.isModelReady)
                    if isPreparingModel {
                        ProgressView().controlSize(.small)
                        if let title = controller.modelMenuTitle { Text(verbatim: title).foregroundStyle(.secondary) }
                    }
                    Spacer()
                }
                if let modelError {
                    Text(modelError).foregroundStyle(.secondary).textSelection(.enabled)
                }
            } header: {
                Step(number: 3, title: "Transcription model", isDone: controller.isModelReady)
            }

            Section {
                Text("Until you add a Summary Profile, Takku writes only the Transcript. A Profile is a model on this Mac (llama.cpp, Ollama, LM Studio) or an OpenAI-compatible provider you trust.")
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    Button("Add a Profile in Settings…") {
                        NSApplication.shared.activate()
                        openSettings()
                    }
                    Link("Examples", destination: URL(string: "https://takku.app/setup#first-setup")!)
                    Spacer()
                }
            } header: {
                Step(number: 4, title: "Summary (optional)", isDone: AppSettings.activeProviderProfile != nil)
            }

            Section("Optional") {
                LaunchAtLoginToggle()
                CalendarToggle()
            }

            Section {
                HStack(alignment: .center) {
                    Image("MenuBarIcon").renderingMode(.template)
                    Text("Takku lives in the menu bar: start a meeting from there or with ⌃⌥⌘R.")
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    Button("Done") { dismissWindow(id: Self.windowID) }
                        .keyboardShortcut(.defaultAction)
                }
            }
        }
        .formStyle(.grouped)
        .frame(width: 560, height: 720)
        // Takku has no Dock icon: without activating it the window would open behind the others.
        .onAppear { NSApplication.shared.activate() }
    }
}

private struct Step: View {
    let number: Int
    let title: LocalizedStringKey
    let isDone: Bool

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: isDone ? "checkmark.circle.fill" : "\(number).circle")
                .foregroundStyle(isDone ? Color.green : Color.secondary)
            Text(title)
        }
    }
}
