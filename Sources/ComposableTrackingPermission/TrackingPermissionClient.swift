import ComposablePermission
import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct TrackingPermissionClient: DependencyKey, Sendable {
    
    /// Returns an authorization status that indicates whether the user grants
    /// the app permission to track the user.
    public var status: () -> PermissionStatus = { .denied }
    
    /// Prompts the user to grant the app permission to track the user.
    public var request: () async -> PermissionStatus = { .denied }
}

extension DependencyValues {
    
    /// A dependency for managing user tracking permission.
    public var trackingPermissionClient: TrackingPermissionClient {
        get { self[TrackingPermissionClient.self] }
        set { self[TrackingPermissionClient.self] = newValue }
    }
}
