import AppTrackingTransparency
import ComposablePermission
import Foundation

extension TrackingPermissionClient {
    
    public static let liveValue = TrackingPermissionClient(
        status: {
            return .make { ATTrackingManager.trackingAuthorizationStatus }
        },
        request: {
            return await .asyncMake {
                await withUnsafeContinuation { continuation in
                    ATTrackingManager.requestTrackingAuthorization(
                        completionHandler: continuation.resume(returning:)
                    )
                }
            }
        }
    )
}
