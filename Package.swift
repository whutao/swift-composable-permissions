// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "swift-composable-permissions",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ComposableCameraPermission",
            targets: ["ComposableCameraPermission"]
        ),
        .library(
            name: "ComposableHealthPermission",
            targets: ["ComposableHealthPermission"]
        ),
        .library(
            name: "ComposableLocalAuthenticationPermission",
            targets: ["ComposableLocalAuthenticationPermission"]
        ),
        .library(
            name: "ComposableLocationPermission",
            targets: ["ComposableLocationPermission"]
        ),
        .library(
            name: "ComposableMotionPermission",
            targets: ["ComposableMotionPermission"]
        ),
        .library(
            name: "ComposablePermission",
            targets: ["ComposablePermission"]
        ),
        .library(
            name: "ComposablePhotoLibraryPermission",
            targets: ["ComposablePhotoLibraryPermission"]
        ),
        .library(
            name: "ComposableTrackingPermission",
            targets: ["ComposableTrackingPermission"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-case-paths",
            from: Version(1, 3, 0)
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies",
            from: Version(1, 2, 0)
        )
    ],
    targets: [
        .target(
            name: "ComposablePermission",
            dependencies: [
                .product(name: "CasePaths", package: "swift-case-paths"),
            ]
        ),
        .target(name: "ComposableCameraPermission"),
        .target(name: "ComposableHealthPermission"),
        .target(name: "ComposableLocalAuthenticationPermission"),
        .target(name: "ComposableLocationPermission"),
        .target(name: "ComposableMotionPermission"),
        .target(name: "ComposablePhotoLibraryPermission"),
        .target(name: "ComposableTrackingPermission"),
    ]
)

package.targets.forEach { target in
    if target.name != "ComposablePermission" {
        target.dependencies.append(contentsOf: [
            .target(name: "ComposablePermission")
        ])
    }
    target.dependencies.append(contentsOf: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DependenciesMacros", package: "swift-dependencies")
    ])
}
