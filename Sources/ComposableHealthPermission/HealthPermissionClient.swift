import ComposablePermission
import Dependencies
import DependenciesMacros
import Foundation
import HealthKit

@DependencyClient
public struct HealthPermissionClient: DependencyKey, Sendable {
    
    /// Returns the app’s authorization status for sharing the specified health data type.
    public var status: (_ for: HKObjectType) -> PermissionStatus = { _ in .denied }
    
    /// Requests permission to save and read the specified data types.
    public var request: (
        _ writing: Set<HKSampleType>,
        _ reading: Set<HKObjectType>
    ) async throws -> Void
}

extension DependencyValues {
    
    /// A dependency for managing health permission.
    public var healthPermissionClient: HealthPermissionClient {
        get { self[HealthPermissionClient.self] }
        set { self[HealthPermissionClient.self] = newValue }
    }
}
