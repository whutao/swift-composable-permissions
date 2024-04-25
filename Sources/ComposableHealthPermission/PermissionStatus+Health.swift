import ComposablePermission
import Foundation
import HealthKit

extension PermissionStatus {
    
    public static func make(
        from rawStatus: () -> HKAuthorizationStatus
    ) -> PermissionStatus {
        return switch rawStatus() {
        case .sharingAuthorized: .granted
        case .sharingDenied: .denied
        case .notDetermined: .undetermined
        @unknown default: .denied
        }
    }
    
    public static func asyncMake(
        from rawStatus: () async -> HKAuthorizationStatus
    ) async -> PermissionStatus {
        let rawStatus = await rawStatus()
        return make { rawStatus }
    }
}
