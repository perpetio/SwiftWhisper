// swift-tools-version:5.9
import PackageDescription

var exclude: [String] = []

#if os(Linux)
// Linux doesn't support CoreML, and will attempt to import the coreml source directory
exclude.append("coreml")
#endif

let package = Package(
    name: "SwiftWhisper",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
    ],
    products: [
        .library(name: "SwiftWhisper", targets: ["SwiftWhisper"])
    ],
    dependencies: [
            // Here we define our package's external dependencies
            // and from where they can be fetched:
        .package(
            url: "https://github.com/ggerganov/whisper.cpp.git",
            from: "1.7.2"
        )
        ],
    targets: [
        .target(name: "SwiftWhisper", dependencies: [.product(name: "whisper", package: "whisper")]),
        .testTarget(name: "WhisperTests", dependencies: [.target(name: "SwiftWhisper")], resources: [.copy("TestResources/")])
    ],
    cxxLanguageStandard: CXXLanguageStandard.cxx11
)
