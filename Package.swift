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
        // Floors match the CocoaPods podspec; the GMA cap stops at the next major (Google renames API there).
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",
            "12.0.0" ..< "14.0.0"
        ),
        .package(
            url: "https://github.com/AppLovin/AppLovin-MAX-Swift-Package.git",
            from: "13.0.0"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "BideaseMobileSDK",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseMobileSDK.xcframework.zip",
            checksum: "7ae914745c83b59c2171df4af65078526e1ee06e62487ab57ff9d388b196fc5c"
        ),
        .binaryTarget(
            name: "BideaseCore",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseCore.xcframework.zip",
            checksum: "836ff7eccd648b83c8925e53f940ffd78047267d91d18d6eac44b87612e5b9be"
        ),
        .binaryTarget(
            name: "BideaseAdapterAdmob",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseAdapterAdmob.xcframework.zip",
            checksum: "a058c80003e6b4b31a6a6cae3266ffd811941a5108baa22bb51e505ea888710d"
        ),
        .binaryTarget(
            name: "BideaseAdapterGAM",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseAdapterGAM.xcframework.zip",
            checksum: "a64690d8f472a1a097a9ff5a5be92733e099777826273777289f5c29be2e4925"
        ),
        .binaryTarget(
            name: "BideaseAdapterAppLovin",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseAdapterAppLovin.xcframework.zip",
            checksum: "2ff57b28d2082a74848e939c4d4e5efae0f274a197060ad8da959ebaccaa5da1"
        ),
        .binaryTarget(
            name: "BideaseMobileTestMode",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseMobileTestMode.xcframework.zip",
            checksum: "a14995623ac54ea118131484cb449e43f079a3ff8e29ab8c33e347b579ce9232"
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
