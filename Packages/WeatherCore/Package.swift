// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherCore",
    platforms: [
         .iOS(.v11),
         .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "WeatherCore",
            targets: ["WeatherCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", .exact(Version("5.5.0"))),
        .package(url: "https://github.com/mxcl/PromiseKit", .exact(Version("6.12.0")))
    ],
    targets: [
        .target(
            name: "WeatherCore",
            dependencies: ["Alamofire", "PromiseKit"],
        path: "Sources"),
        .testTarget(
            name: "WeatherCoreTests",
            dependencies: ["WeatherCore"])
    ]
)
