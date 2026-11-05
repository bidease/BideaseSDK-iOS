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
            checksum: "06c129561ba3dd2733eb6264eca5c299d7d21f9bd20ece8ad5bd2732dd95eb0e"
        ),
        .binaryTarget(
            name: "BideaseCore",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseCore.xcframework.zip",
            checksum: "e84b6cdb3d74aab8deffe555a65fe7a156ba46b083658633fff5e6a8bdf769f4"
        ),
        .binaryTarget(
            name: "BideaseAdapterAdmob",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseAdapterAdmob.xcframework.zip",
            checksum: "96dfff16d00efa64f94c441bd10c1468293a075fa7a5c0dd530123474e4ff5d4"
        ),
        .binaryTarget(
            name: "BideaseAdapterGAM",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseAdapterGAM.xcframework.zip",
            checksum: "d2d330d6d02600db2b4bfb1447af714a5fc2f4e7a40763cce55c7af488967fd9"
        ),
        .binaryTarget(
            name: "BideaseAdapterAppLovin",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseAdapterAppLovin.xcframework.zip",
            checksum: "18f5451cd7547ce57d59f1181158dc7d18eb49f68efd5a90f96c14b20f9d64a6"
        ),
        .binaryTarget(
            name: "BideaseMobileTestMode",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.3/BideaseMobileTestMode.xcframework.zip",
            checksum: "f3ec29e855ef14a7b58091640a8a46430bf736990306b94233b89462833eb3e5"
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
