// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SFImage",
    products: [.library(name: "SFImage", targets: ["SFImage"]), ],
    targets: [
        .target(name: "SFImage", dependencies: ["FreeImage"]),
        .systemLibrary(name: "FreeImage", pkgConfig: "freeimage")
    ]
)
