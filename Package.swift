// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "XYDebugKit",
    products: [
        .library(
            name: "XYDebugKit",
            targets: ["XYDebugKit"]),
    ],
    targets: [
        .target(
            name: "XYDebugKit",
            dependencies: []),
        .testTarget(
            name: "XYDebugKitTests",
            dependencies: ["XYDebugKit"]),
    ]
)
