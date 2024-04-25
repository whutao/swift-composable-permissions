import CasePaths
import Foundation

/// A user-granted app permission to a capability.
@CasePathable
public enum PermissionStatus: Sendable {
    
    /// A status that indicates the user has explicitly
    /// granted an app permission to a capability.
    case granted
    
    /// A status that indicates the user has explicitly
    /// denied an app permission to a capability.
    case denied
    
    /// A status that indicates the user hasn’t yet granted or denied authorization.
    case undetermined
    
    /// A status that indicates a capability is not supported.
    case unsupported
}
