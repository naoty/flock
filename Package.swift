// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "flockLib",
    products: [
        .library(
            name: "flockLib", 
            targets: ["flock"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/SourceKitten", from: "0.29.0"),
        .package(url: "https://github.com/kylef/PathKit", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "flock", 
            dependencies: ["SourceKittenFramework", "PathKit"]
        )
    ]
)