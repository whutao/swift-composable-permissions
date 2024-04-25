import ComposablePermission
import Foundation
import Photos

extension PhotoLibraryPermissionClient {
    
    public static let liveValue = PhotoLibraryPermissionClient(
        addOnly: {
            return .make { PHPhotoLibrary.authorizationStatus(for: .addOnly) }
        },
        readWrite: {
            return .make { PHPhotoLibrary.authorizationStatus(for: .readWrite) }
        },
        requestAddOnly: {
            return await .asyncMake {
                await withUnsafeContinuation { continuation in
                    PHPhotoLibrary.requestAuthorization(
                        for: .addOnly,
                        handler: continuation.resume(returning:)
                    )
                }
            }
        },
        requestReadWrite: {
            return await .asyncMake {
                await withUnsafeContinuation { continuation in
                    PHPhotoLibrary.requestAuthorization(
                        for: .readWrite,
                        handler: continuation.resume(returning:)
                    )
                }
            }
        }
    )
}
