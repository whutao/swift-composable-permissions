import ComposablePermission
import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct LocalAuthenticationPermissionClient: DependencyKey, Sendable {
    
    /// Returns an authorization status that indicates whether the user grants
    /// the app permission to request user authentication
    /// with biometry, Apple Watch, or the device passcode.
    public var status: (
        _ forBiometryOnly: Bool
    ) -> PermissionStatus = { _ in .denied }
    
    /// Prompts the user to grant the app permission to request user authentication
    /// with biometry, Apple Watch, or the device passcode.
    public var request: (
        _ forBiometryOnly: Bool,
        _ withLocalizedReason: String
    ) async -> PermissionStatus = { _, _ in .denied }
}

extension DependencyValues {
    
    /// A dependency for managing local authentication permission.
    public var localAuthenticationPermissionClient: LocalAuthenticationPermissionClient {
        get { self[LocalAuthenticationPermissionClient.self] }
        set { self[LocalAuthenticationPermissionClient.self] = newValue }
    }
}
