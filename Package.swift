// swift-tools-version:5.9
// GENERATED FILE — do not edit by hand.
// Source: iosApp/SPM/Package.swift.template in bidease/mobile-sdk
// Regenerate: iosApp/SPM/make-spm-package.sh

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
        // Ranges match what iosApp.xcodeproj resolves against, i.e. what the adapters are built and tested with.
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
            checksum: "4566503e7b05add69af6b554e64c664bf22364aeecf373f4f0ce083942f8fb40"
        ),
        .binaryTarget(
            name: "BideaseCore",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseCore.xcframework.zip",
            checksum: "8364560f8b40864d2f6c1511f2a479ebbac86166c7de45046b668b28e7be7824"
        ),
        .binaryTarget(
            name: "BideaseAdapterAdmob",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseAdapterAdmob.xcframework.zip",
            checksum: "593358be6dbf8db59d822b854dccf7f6df695c934044c5f9405d17c09112ab64"
        ),
        .binaryTarget(
            name: "BideaseAdapterGAM",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseAdapterGAM.xcframework.zip",
            checksum: "502a95deb4a1efb83d5f6a3d1c6bfabd837d640ecea2981bce692ab5aafd40ab"
        ),
        .binaryTarget(
            name: "BideaseAdapterAppLovin",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseAdapterAppLovin.xcframework.zip",
            checksum: "ad6a39b3914d98d1b0de0f248743bc455877acc0760cc673a51adc8d1c8b07c5"
        ),
        .binaryTarget(
            name: "BideaseMobileTestMode",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/2.2.8/BideaseMobileTestMode.xcframework.zip",
            checksum: "c2402f02fa8486b95f42ebf98c990118f893aef5342ade3a4acd4e66a1c1ed42"
        ),

        // Wrapper targets exist only because a binaryTarget cannot declare dependencies or carry
        // resources. They ship no API — consumers still `import BideaseMobileSDK` etc.

        // Carries the JS runtime assets (mraid/bidease/bundle/info) that the podspec ships as
        // `resource_bundles`. SPM renames this to "BideaseSDK_BideaseCoreSupport.bundle";
        // BundleResources.kt finds it by looking for bidease.js inside the app's bundles.
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
