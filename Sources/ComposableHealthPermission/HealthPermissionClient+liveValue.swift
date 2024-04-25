import ComposablePermission
import Foundation
import HealthKit

extension HealthPermissionClient {
    
    public static let liveValue = HealthPermissionClient(
        status: { hkObjectType in
            return .make { HKHealthStore().authorizationStatus(for: hkObjectType) }
        },
        request: { writingHKSampleTypes, readingHKObjetTypes in
            try await withUnsafeThrowingContinuation { continuation in
                HKHealthStore().requestAuthorization(
                    toShare: writingHKSampleTypes,
                    read: readingHKObjetTypes
                ) { _, error in
                    if let error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume()
                    }
                }
            }
        }
    )
}
