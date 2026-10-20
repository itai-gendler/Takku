import AppKit
import SwiftUI

/// What Takku keeps on this Mac outside the Vault: the audio (how long, how much, where, and
/// deleting it ahead of time) and the Summary log (on or off, how much, where, deleting it).
struct RecordingsSection: View {
    @State private var days = AppSettings.retentionDays
    @State private var size: Int64 = 0
    @State private var isConfirmingDeletion = false
    @AppStorage(AppSettings.keepSummaryLogKey) private var keepSummaryLog = true
    @State private var summaryLogSize: Int64 = 0
    @State private var isConfirmingSummaryLogDeletion = false

    var body: some View {
        Section {
            Stepper(value: $days, in: 1...90) {
                Text("Keep audio for \(days) days")
            }
            // Applied by the cleanup at launch and once a day: a click too many on the Stepper
            // must not delete audio on the spot.
            .onChange(of: days) { AppSettings.retentionDays = days }
            LabeledContent("Audio on this Mac") {
                HStack {
                    Text(size.formatted(.byteCount(style: .file)))
                    Button("Show in Finder", action: showInFinder)
                    Button("Delete audio", role: .destructive) { isConfirmingDeletion = true }
                        .disabled(size == 0)
                }
            }
            Toggle("Keep a Summary log", isOn: $keepSummaryLog)
            LabeledContent("Summary log") {
                HStack {
                    Text(summaryLogSize.formatted(.byteCount(style: .file)))
                    Button("Show in Finder", action: showSummaryLogInFinder)
                    Button("Delete log", role: .destructive) { isConfirmingSummaryLogDeletion = true }
                        .disabled(summaryLogSize == 0)
                }
            }
        } header: {
            Text("Recordings")
        } footer: {
            Text("About 20 MB per hour of Meeting. Notes and Transcripts stay in the Vault: without the audio, Retry makes only the Summary again. The Summary log keeps what was sent to the model and its replies, in ~/.takku/summary-log, to improve the Templates: up to 5 MB, the oldest go first.")
                .foregroundStyle(.secondary)
        }
        .onAppear {
            size = RecordingStorage.audioSize()
            summaryLogSize = SummaryLogStorage.size()
        }
        .confirmationDialog(
            String(localized: "Delete the audio of all concluded Meetings?"),
            isPresented: $isConfirmingDeletion
        ) {
            Button("Delete audio", role: .destructive) {
                RecordingStorage.deleteAudio(olderThanDays: 0)
                size = RecordingStorage.audioSize()
            }
        } message: {
            Text("It cannot be undone. Meetings being recorded or processed are not touched.")
        }
        .confirmationDialog(
            String(localized: "Delete the Summary log?"),
            isPresented: $isConfirmingSummaryLogDeletion
        ) {
            Button("Delete log", role: .destructive) {
                SummaryLogStorage.deleteAll()
                summaryLogSize = SummaryLogStorage.size()
            }
        } message: {
            Text("It cannot be undone. Notes and Transcripts in the Vault are not touched.")
        }
    }

    private func showInFinder() {
        let folder = MeetingRecorder.recordingsDirectory
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        NSWorkspace.shared.open(folder)
    }

    private func showSummaryLogInFinder() {
        let folder = TakkuFolder.summaryLogFolder
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        NSWorkspace.shared.open(folder)
    }
}
