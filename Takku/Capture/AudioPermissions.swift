import AVFoundation
import AppKit
import os

private let logger = Logger(subsystem: "app.takku.takku", category: "permissions")

/// The microphone and system audio permissions, asked from the welcome window so that macOS does
/// not interrupt the first call with its prompts.
@MainActor
enum AudioPermissions {
    static var microphoneAllowed: Bool {
        AVCaptureDevice.authorizationStatus(for: .audio) == .authorized
    }

    /// The system audio has no request of its own: macOS asks when a process tap starts, so one
    /// runs for a moment, recording nothing. Whether it was allowed cannot be read.
    static func request() async {
        _ = await AVCaptureDevice.requestAccess(for: .audio)
        let capture = SystemAudioCapture()
        do {
            try capture.start { _, _ in }
            try? await Task.sleep(for: .seconds(1))
            capture.stop()
        } catch {
            logger.error("System audio tap for the permission failed: \(error, privacy: .public)")
        }
    }

    static func openSystemAudioSettings() {
        NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture")!)
    }
}
