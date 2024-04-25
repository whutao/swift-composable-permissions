import AVFoundation
import ComposablePermission
import Foundation

extension PermissionStatus {
    
    public static func makeForVideo(
        from rawStatus: () -> AVAuthorizationStatus
    ) -> PermissionStatus {
        return switch rawStatus() {
        case .authorized: .granted
        case .notDetermined: .undetermined
        case .denied, .restricted: .denied
        @unknown default: .denied
        }
    }
    
    public static func asyncMakeForVideo(
        from rawStatus: () async -> AVAuthorizationStatus
    ) async -> PermissionStatus {
        let rawStatus = await rawStatus()
        return makeForVideo { rawStatus }
    }
}
