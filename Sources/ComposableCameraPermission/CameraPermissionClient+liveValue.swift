import AVFoundation
import ComposablePermission
import Foundation

extension CameraPermissionClient {
    
    public static let liveValue = CameraPermissionClient(
        status: {
            return .makeForVideo { AVCaptureDevice.authorizationStatus(for: .video) }
        },
        request: {
            _ = await AVCaptureDevice.requestAccess(for: .video)
            return .makeForVideo { AVCaptureDevice.authorizationStatus(for: .video) }
        }
    )
}
