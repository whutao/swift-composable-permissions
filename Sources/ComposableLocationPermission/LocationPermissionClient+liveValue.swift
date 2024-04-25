import ComposablePermission
import CoreLocation

extension LocationPermissionClient {
    
    public static let liveValue: LocationPermissionClient = {
        func always() -> PermissionStatus {
            return .makeForAlways { CLLocationManager().authorizationStatus }
        }
        func whenInUse() -> PermissionStatus {
            return .makeForWhenInUse { CLLocationManager().authorizationStatus }
        }
        return LocationPermissionClient(
            always: always,
            whenInUse: whenInUse,
            requestAlways: {
                let status = always()
                
                guard status == .undetermined else {
                    return status
                }
                
                let clLocationManager = CLLocationManager()
                return await.asyncMakeForAlways {
                    await withCheckedContinuation { continuation in
                        let delegate = Delegate(continuation: continuation)
                        clLocationManager.delegate = delegate
                        clLocationManager.requestAlwaysAuthorization()
                    }
                }
            },
            requestWhenInUse: {
                let status = whenInUse()
                
                guard status == .undetermined else {
                    return status
                }
                
                let clLocationManager = CLLocationManager()
                return await .asyncMakeForWhenInUse {
                    await withCheckedContinuation { continuation in
                        let delegate = Delegate(continuation: continuation)
                        clLocationManager.delegate = delegate
                        clLocationManager.requestWhenInUseAuthorization()
                    }
                }
            }
        )
    }()
}

private final class Delegate: NSObject, CLLocationManagerDelegate {
    
    private let continuation: CheckedContinuation<CLAuthorizationStatus, Never>
    
    init(continuation: CheckedContinuation<CLAuthorizationStatus, Never>) {
        self.continuation = continuation
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        continuation.resume(returning: manager.authorizationStatus)
    }
}
