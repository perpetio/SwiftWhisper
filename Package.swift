// swift-tools-version:5.5
import PackageDescription

var exclude: [String] = []

#if os(Linux)
// Linux doesn't support CoreML, and will attempt to import the coreml source directory
exclude.append("coreml")
#endif

let package = Package(
    name: "SwiftWhisper",
    platforms: [
        .macOS(.v12),
        .iOS(.v14),
        .watchOS(.v4),
        .tvOS(.v14)
    ],
    products: [
        .library(name: "SwiftWhisper", targets: ["SwiftWhisper"])
    ],
    dependencies: [
            // Here we define our package's external dependencies
            // and from where they can be fetched:
            .package(
                url: "https://github.com/duykienvp/whisper.cpp.git",
                .revision("c118733a29ad4a984015a5c08fd585086d01087a")  // 1.6.2
            )
        ],
    targets: [
        .target(name: "SwiftWhisper", dependencies: [.product(name: "whisper", package: "whisper.cpp")]),
        .testTarget(name: "WhisperTests", dependencies: [.target(name: "SwiftWhisper")], resources: [.copy("TestResources/")])
    ],
    cxxLanguageStandard: CXXLanguageStandard.cxx11
)
