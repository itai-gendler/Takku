import AppKit
import ImageIO
import ScreenCaptureKit
import UniformTypeIdentifiers

/// Takes a Screenshot: the whole display showing the frontmost window, at its native resolution,
/// as JPEG. Needs the Screen Recording permission, which the system audio does not give.
enum ScreenshotTaker {
    enum Failure: LocalizedError {
        case noDisplay
        case encoding

        var errorDescription: String? {
            switch self {
            case .noDisplay: String(localized: "No display to take it from.")
            case .encoding: String(localized: "The image could not be saved as JPEG.")
            }
        }
    }

    /// Whether Takku may take Screenshots. The first time it asks; macOS applies a permission
    /// given then only when Takku is reopened.
    static func isAllowed() -> Bool {
        CGPreflightScreenCaptureAccess() || CGRequestScreenCaptureAccess()
    }

    static func jpeg() async throws -> Data {
        let content = try await SCShareableContent.excludingDesktopWindows(true, onScreenWindowsOnly: true)
        let displayID = frontmostWindowDisplay() ?? CGMainDisplayID()
        guard let display = content.displays.first(where: { $0.displayID == displayID }) ?? content.displays.first else {
            throw Failure.noDisplay
        }
        let filter = SCContentFilter(display: display, excludingWindows: [])
        let configuration = SCStreamConfiguration()
        let scale = CGFloat(filter.pointPixelScale)
        configuration.width = Int(filter.contentRect.width * scale)
        configuration.height = Int(filter.contentRect.height * scale)
        configuration.showsCursor = false
        let image = try await SCScreenshotManager.captureImage(contentFilter: filter, configuration: configuration)
        return try jpegData(image)
    }

    /// The display under the middle of the frontmost app's front window; `nil` without one.
    /// The window list is in front-to-back order and gives bounds without the permission.
    private static func frontmostWindowDisplay() -> CGDirectDisplayID? {
        guard let pid = NSWorkspace.shared.frontmostApplication?.processIdentifier,
              let windows = CGWindowListCopyWindowInfo([.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID)
                as? [[CFString: Any]],
              let window = windows.first(where: {
                  ($0[kCGWindowOwnerPID] as? pid_t) == pid && ($0[kCGWindowLayer] as? Int) == 0
              }),
              let boundsInfo = window[kCGWindowBounds] as? NSDictionary,
              let bounds = CGRect(dictionaryRepresentation: boundsInfo)
        else { return nil }
        var displayID = CGDirectDisplayID()
        var count: UInt32 = 0
        guard CGGetDisplaysWithPoint(CGPoint(x: bounds.midX, y: bounds.midY), 1, &displayID, &count) == .success,
              count > 0
        else { return nil }
        return displayID
    }

    private static func jpegData(_ image: CGImage) throws -> Data {
        let data = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(data, UTType.jpeg.identifier as CFString, 1, nil) else {
            throw Failure.encoding
        }
        CGImageDestinationAddImage(destination, image, [kCGImageDestinationLossyCompressionQuality: 0.8] as CFDictionary)
        guard CGImageDestinationFinalize(destination) else { throw Failure.encoding }
        return data as Data
    }
}
