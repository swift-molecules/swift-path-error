// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-path-error",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Path Error",
            targets: ["Path Error"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-path.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-error.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Path Error",
            dependencies: [
                .product(name: "Path", package: "swift-path"),
                .product(name: "Error", package: "swift-error"),
            ],
            swiftSettings: [
                .define(
                    "PATH_AVAILABLE",
                    .when(platforms: [
                        .macOS, .iOS, .tvOS, .watchOS, .visionOS,
                        .linux, .windows, .android, .openbsd,
                    ])
                )
            ]
        ),
        .testTarget(
            name: "Path Error Tests",
            dependencies: [
                "Path Error",
                .product(name: "Path", package: "swift-path"),
                .product(name: "Error", package: "swift-error"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
