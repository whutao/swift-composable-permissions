# ✋ Composable permissions

<p>
    <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" />
    <img src="https://img.shields.io/badge/iOS-15.0+-red.svg" />
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" />
</p>

## Contents

- [Motivation](#motivation)
- [Features](#features)
    - [Universal status](#universal-status)
    - [Microlibraries](#microlibraries)
    - [Dependency clients](#dependency-clients)
- [Usage](#usage)
- [Installation](#installation)
- [License](#license)

## Motivation

Apple does not provide a universal API for managing permission statuses. Their frameworks have own status models, request mechaninsms and status handlers. 

Also, Apple frameworks' permission status management is not testable.

## Features

### Universal status

There is a universal status model.
```swift
enum PermissionStatus {
    
    /// A status that indicates the user has explicitly
    /// granted an app permission to a capability.
    case granted
    
    /// A status that indicates the user has explicitly
    /// denied an app permission to a capability.
    case denied
    
    /// A status that indicates the user hasn’t
    /// yet granted or denied authorization.
    case undetermined
    
    /// A status that indicates a capability is not supported.
    case unsupported
}
```

### Microlibraries

There are several microlibraries. Each one has a manager for a certain status kind.

| Name | Apple framework | Microlibrary to import |
| :--- | :-------------- | :--------------------- |
| Camera | AVFoundation | ComposableCameraPermission |
| Health | HealthKit | ComposableHealthPermission |
| Local auth | LocalAuthentication | ComposableLocalAuthenticationPermission |
| Location | CoreLocation | ComposableLocationPermission |
| Motion | CoreMotion | ComposableMotionPermission |
| Photo library | Photos | ComposablePhotoLibraryPermission |
| Tracking | AppTrackingTransparency | ComposableTrackingPermission |

### Dependency clients

Each permission manager is a dependency client (see [swift-dependencies](https://github.com/pointfreeco/swift-dependencies)). This approach provides testability, and allows to easily integrate the library into a TCA project.

## Usage

There is an example how to use a location permission client
```swift
import ComposableLocationPermission

@Dependency(\.locationPermissionClient)
var locationPermission

let whenInUsePermissionStatus = await locationPermission.requestWhenInUse()

if whenInUsePermissionStatus == .granted {
    ...
}
```

## Installation

You can add the library to an Xcode project by adding it as a package dependency.

> https://github.com/whutao/swift-composable-permissions

If you want to use the library in a [SwiftPM](https://swift.org/package-manager/) project, it's as simple as adding it to a `dependencies` clause in your `Package.swift`:
``` swift
dependencies: [
    .package(url: "https://github.com/whutao/swift-composable-permissions", from: "1.0.0")
]
```
and then adding needed microlibraries to a target dependencies
```swift
.target(name: ..., dependencies: [
    .product(
        name: "ComposableLocationPermission",
        package: "swift-composable-permissions"
    )
])
```

## License

All modules are released under the MIT license. See [LICENSE](LICENSE) for details.
