import ComposablePermission
import Foundation
import Photos

extension PermissionStatus {
    
    public static func make(
        from rawStatus: () -> PHAuthorizationStatus
    ) -> PermissionStatus {
        return switch rawStatus() {
        case .limited, .authorized: .granted
        case .notDetermined: .undetermined
        case .denied, .restricted: .denied
        @unknown default: .denied
        }
    }
    
    public static func asyncMake(
        from rawStatus: () async -> PHAuthorizationStatus
    ) async -> PermissionStatus {
        let rawStatus = await rawStatus()
        return make { rawStatus }
    }
}
