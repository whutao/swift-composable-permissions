import ComposablePermission
import CoreLocation
import Foundation

extension PermissionStatus {
    
    public static func makeForAlways(
        from rawStatus: () -> CLAuthorizationStatus
    ) -> PermissionStatus {
        return switch rawStatus() {
        case .authorizedAlways, .authorized: .granted
        case .notDetermined: .undetermined
        case .denied, .restricted, .authorizedWhenInUse: .denied
        @unknown default: .denied
        }
    }
    
    public static func makeForWhenInUse(
        from rawStatus: () -> CLAuthorizationStatus
    ) -> PermissionStatus {
        return switch rawStatus() {
        case .authorizedAlways, .authorized, .authorizedWhenInUse: .granted
        case .notDetermined: .undetermined
        case .denied, .restricted: .denied
        @unknown default: .denied
        }
    }
    
    public static func asyncMakeForAlways(
        from rawStatus: () async -> CLAuthorizationStatus
    ) async -> PermissionStatus {
        let rawStatus = await rawStatus()
        return makeForAlways { rawStatus }
    }
    
    public static func asyncMakeForWhenInUse(
        from rawStatus: () async -> CLAuthorizationStatus
    ) async -> PermissionStatus {
        let rawStatus = await rawStatus()
        return makeForWhenInUse { rawStatus }
    }
}
