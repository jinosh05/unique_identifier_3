// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "unique_identifier_3",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "unique-identifier-3", targets: ["unique_identifier_3"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "unique_identifier_3",
            dependencies: [],
            path: "Sources/unique_identifier_3",
            cSettings: [
                .headerSearchPath("include")
            ]
        )
    ]
)
