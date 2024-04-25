import ComposablePermission
import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct MotionPermissionClient: DependencyKey, Sendable {
    
    /// Returns an authorization status that indicates whether the user grants
    /// the app permission to retrieve stored motion data.
    public var status: () -> PermissionStatus = { .denied }
    
    /// Prompts the user to grant the app permission to retrieve stored motion data.
    public var request: () async -> PermissionStatus = { .denied }
}

extension DependencyValues {
    
    /// A dependency for managing stored device motion data access permission.
    public var motionPermissionClient: MotionPermissionClient {
        get { self[MotionPermissionClient.self] }
        set { self[MotionPermissionClient.self] = newValue }
    }
}
