// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "PPJailbreakDetection",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "PPJailbreakDetection", targets: ["PPJailbreakDetection"]),
    ],
    targets: [
        .target(name: "PPJailbreakDetection"),
        .testTarget(name: "PPJailbreakDetectionTests", dependencies: ["PPJailbreakDetection"]),
    ]
)
