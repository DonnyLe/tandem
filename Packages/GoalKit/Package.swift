// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "GoalKit",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "GoalKit", targets: ["GoalKit"]),
    ],
    targets: [
        .target(name: "GoalKit"),
        .testTarget(name: "GoalKitTests", dependencies: ["GoalKit"]),
    ]
)
