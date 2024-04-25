import ComposablePermission
import Foundation
import LocalAuthentication

extension LocalAuthenticationPermissionClient {
    
    public static let liveValue: LocalAuthenticationPermissionClient = {
        func status(biometryOnly: Bool) -> PermissionStatus {
            let context = LAContext()
            
            let policy: LAPolicy = {
                if biometryOnly {
                    return .deviceOwnerAuthenticationWithBiometrics
                } else {
                    return .deviceOwnerAuthentication
                }
            }()
            
            var error: NSError?
            let isReady = context.canEvaluatePolicy(policy, error: &error)
            
            guard biometryOnly else {
                return isReady ? .granted : .denied
            }
            
            guard context.biometryType != .none else {
                return .unsupported
            }
            
            return switch error?.code {
            case nil where isReady: .granted
            case LAError.biometryNotEnrolled.rawValue: .denied
            case LAError.biometryNotAvailable.rawValue: .unsupported
            default: .unsupported
            }
        }
        return LocalAuthenticationPermissionClient(
            status: status,
            request: { biometryOnly, localizedReason in
                await withUnsafeContinuation { continuation in
                    LAContext().evaluatePolicy(
                        .deviceOwnerAuthentication,
                        localizedReason: localizedReason
                    ) { _, _ in
                        continuation.resume()
                    }
                }
                return status(biometryOnly: biometryOnly)
            }
        )
    }()
}
