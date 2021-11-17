// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataFlow",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "DataFlow",
            targets: ["DataFlow"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DataFlow",
            dependencies: []),
        .testTarget(
            name: "DataFlowTests",
            dependencies: ["DataFlow"]),
    ]
)
