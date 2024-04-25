import ComposablePermission
import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct LocationPermissionClient: DependencyKey, Sendable {
    
    /// Returns an authorization status that indicates whether the user grants
    /// the app permission to a track user location always.
    public var always: () -> PermissionStatus = { .denied }
    
    /// Returns an authorization status that indicates whether the user grants
    /// the app permission to a track user location only when the app is in use.
    public var whenInUse: () -> PermissionStatus = { .denied }
    
    /// Prompts the user to grant the app permission to a track user location always.
    public var requestAlways: () async -> PermissionStatus = { .denied }
    
    /// Prompts the user to grant the app permission to a track user location only when
    /// the app is in use.
    public var requestWhenInUse: () async -> PermissionStatus = { .denied }
}

extension DependencyValues {
    
    /// A dependency for managing location permission.
    public var locationPermissionClient: LocationPermissionClient {
        get { self[LocationPermissionClient.self] }
        set { self[LocationPermissionClient.self] = newValue }
    }
}
