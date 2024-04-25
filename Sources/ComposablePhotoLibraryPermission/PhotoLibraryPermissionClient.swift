import ComposablePermission
import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct PhotoLibraryPermissionClient: DependencyKey, Sendable {
    
    /// Returns an authorization status that indicates whether the user grants
    /// the app permission to only add to the photo library.
    public var addOnly: () -> PermissionStatus = { .denied }
    
    /// Returns an authorization status that indicates whether the user grants
    /// the app permission to read from and write to the photo library.
    public var readWrite: () -> PermissionStatus = { .denied }
    
    /// Prompts the user to grant the app permission to only add to the photo library.
    public var requestAddOnly: () async -> PermissionStatus = { .denied }
    
    /// Prompts the user to grant the app permission to read from and write to the photo library.
    public var requestReadWrite: () async -> PermissionStatus = { .denied }
}

extension DependencyValues {
    
    /// A dependency for managing photo library permission.
    public var photoLibraryPermissionClient: PhotoLibraryPermissionClient {
        get { self[PhotoLibraryPermissionClient.self] }
        set { self[PhotoLibraryPermissionClient.self] = newValue }
    }
}
