// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "IBAnimatable",
    // platforms: [.iOS("9.0")],
    products: [
        .library(name: "IBAnimatable", targets: ["IBAnimatable"])
    ],
    targets: [
        .target(
            name: "IBAnimatable",
            path: "Sources"
        )
    ]
)
