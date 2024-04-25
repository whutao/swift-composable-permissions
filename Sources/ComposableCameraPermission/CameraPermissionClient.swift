import ComposablePermission
import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct CameraPermissionClient: DependencyKey, Sendable {
    
    /// Returns an authorization status that indicates whether the user grants
    /// the app permission to use device camera.
    public var status: () -> PermissionStatus = { .denied }
    
    /// Prompts the user to grant the app permission to use device camera.
    public var request: () async -> PermissionStatus = { .denied }
}

extension DependencyValues {
    
    /// A dependency for managing camera permission.
    public var cameraPermissionClient: CameraPermissionClient {
        get { self[CameraPermissionClient.self] }
        set { self[CameraPermissionClient.self] = newValue }
    }
}
