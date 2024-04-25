import AppTrackingTransparency
import ComposablePermission
import Foundation

extension PermissionStatus {
    
    public static func make(
        from rawStatus: () -> ATTrackingManager.AuthorizationStatus
    ) -> PermissionStatus {
        return switch rawStatus() {
        case .authorized: .granted
        case .notDetermined: .undetermined
        case .denied, .restricted: .denied
        @unknown default: .denied
        }
    }
    
    public static func asyncMake(
        from rawStatus: () async -> ATTrackingManager.AuthorizationStatus
    ) async -> PermissionStatus {
        let rawStatus = await rawStatus()
        return make { rawStatus }
    }
}
