import ComposablePermission
import CoreMotion
import Foundation

extension PermissionStatus {
    
    public static func make(
        from rawStatus: () -> CMAuthorizationStatus
    ) -> PermissionStatus {
        return switch rawStatus() {
        case .authorized: .granted
        case .notDetermined: .undetermined
        case .denied, .restricted: .denied
        @unknown default: .denied
        }
    }
    
    public static func asyncMake(
        from rawStatus: () async -> CMAuthorizationStatus
    ) async -> PermissionStatus {
        let rawStatus = await rawStatus()
        return make { rawStatus }
    }
}
