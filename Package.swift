// swift-tools-version:5.9
// GENERATED FILE — do not edit by hand. Edits are overwritten on the next SDK release.
// Questions: be-sdk@bidease.com

import PackageDescription

let package = Package(
    name: "BideaseSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "BideaseSDK", targets: ["BideaseCoreSupport"]),
        .library(name: "BideaseSDKAdapterAdmob", targets: ["BideaseAdapterAdmobSupport"]),
        .library(name: "BideaseSDKAdapterGAM", targets: ["BideaseAdapterGAMSupport"]),
        .library(name: "BideaseSDKAdapterAppLovinMax", targets: ["BideaseAdapterAppLovinSupport"]),
        .library(name: "BideaseSDKTestMode", targets: ["BideaseMobileTestMode"]),
    ],
    dependencies: [
        // Kept in sync with the version ranges declared by the CocoaPods podspec.
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",
            "12.0.0" ..< "13.1.0"
        ),
        .package(
            url: "https://github.com/AppLovin/AppLovin-MAX-Swift-Package.git",
            from: "13.0.0"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "BideaseMobileSDK",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseMobileSDK.xcframework.zip",
            checksum: "1e8428c046411131b899f137c2f7dcd614ad1e4afe7cf066d1409e77a4a879c3"
        ),
        .binaryTarget(
            name: "BideaseCore",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseCore.xcframework.zip",
            checksum: "0a5a414e5e37dd22c355eb971c4cecf6efd73006eafadb0d6a0d5866c13cf6fa"
        ),
        .binaryTarget(
            name: "BideaseAdapterAdmob",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseAdapterAdmob.xcframework.zip",
            checksum: "c9e1c8a1af056fc67ad471947b757c1eb844376f5f60743abafa26077d5c971a"
        ),
        .binaryTarget(
            name: "BideaseAdapterGAM",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseAdapterGAM.xcframework.zip",
            checksum: "1411640713d46edd03b650a5b44eae8720b06ba7362e155e55b52b4f002f08eb"
        ),
        .binaryTarget(
            name: "BideaseAdapterAppLovin",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseAdapterAppLovin.xcframework.zip",
            checksum: "5f8800f03232466d6406fa10fa89a83feaed552f05645e72e2f5b96f6fbec70b"
        ),
        .binaryTarget(
            name: "BideaseMobileTestMode",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseMobileTestMode.xcframework.zip",
            checksum: "0a7292dba4fd9817b1c795eab29068f7961d305b4e33d84d8be5009bc375ff9f"
        ),

        // Wrapper targets exist only because a binaryTarget cannot declare dependencies or carry
        // resources. They ship no API — consumers still `import BideaseMobileSDK` etc.

        // Carries the JS runtime assets the SDK loads at runtime. Do not remove or rename them.
        .target(
            name: "BideaseCoreSupport",
            dependencies: [
                "BideaseMobileSDK",
                "BideaseCore",
            ],
            resources: [
                .copy("bidease.js"),
                .copy("bundle.js"),
                .copy("info.json"),
                .copy("mraid.js"),
            ]
        ),
        .target(
            name: "BideaseAdapterAdmobSupport",
            dependencies: [
                "BideaseAdapterAdmob",
                "BideaseCoreSupport",
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ]
        ),
        .target(
            name: "BideaseAdapterGAMSupport",
            dependencies: [
                "BideaseAdapterGAM",
                "BideaseCoreSupport",
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ]
        ),
        .target(
            name: "BideaseAdapterAppLovinSupport",
            dependencies: [
                "BideaseAdapterAppLovin",
                "BideaseCoreSupport",
                .product(name: "AppLovinSDK", package: "AppLovin-MAX-Swift-Package"),
            ]
        ),
    ]
)
