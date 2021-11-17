// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Models",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Models",
            targets: ["Models"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Models",
            dependencies: []),
        .testTarget(
            name: "ModelsTests",
            dependencies: ["Models"]),
    ]
)
