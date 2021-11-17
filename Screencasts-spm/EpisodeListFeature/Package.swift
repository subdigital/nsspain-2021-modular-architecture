// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EpisodeListFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "EpisodeListFeature",
            targets: ["EpisodeListFeature"]),
   ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
        .package(name: "Networking", path: "../Networking"),
        .package(name: "DataFlow", path: "../DataFlow")
    ],
    targets: [
        .target(
            name: "EpisodeListFeature",
            dependencies: [
                "Models", "Networking", "DataFlow"
            ]),
        .testTarget(
            name: "EpisodeListFeatureTests",
            dependencies: ["EpisodeListFeature"]),
    ]
)

