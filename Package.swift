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
                name: "whisper.cpp", path: "../whisper.cpp"
            )
        ],
    targets: [
        .target(name: "SwiftWhisper", dependencies: [.product(name: "whisper", package: "whisper.cpp")]),
        .testTarget(name: "WhisperTests", dependencies: [.target(name: "SwiftWhisper")], resources: [.copy("TestResources/")])
    ],
    cxxLanguageStandard: CXXLanguageStandard.cxx11
)
