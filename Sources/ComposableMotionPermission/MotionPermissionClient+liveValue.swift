import ComposablePermission
import CoreMotion
import Dependencies
import Foundation

extension MotionPermissionClient {
    
    public static let liveValue = MotionPermissionClient(
        status: {
            return .make { CMMotionActivityManager.authorizationStatus() }
        },
        request: {
            let manager = CMMotionActivityManager()
            await withUnsafeContinuation { continuation in
                manager.queryActivityStarting(from: .now, to: .now, to: .main) { _, _ in
                    continuation.resume()
                }
            }
            manager.stopActivityUpdates()
            return await .asyncMake { CMMotionActivityManager.authorizationStatus() }
        }
    )
}
