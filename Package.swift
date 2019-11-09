// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "IBAnimatable",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "IBAnimatable", targets: ["IBAnimatable"])
    ],
    targets: [
        .target(
            name: "IBAnimatable",
            path: "Sources"
        ),
        .testTarget(
            name: "IBAnimatableTests",
            dependencies: ["IBAnimatable"],
            path: "IBAnimatable/IBAnimatableTests"
        )
    ]
)
