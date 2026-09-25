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
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.0/BideaseMobileSDK.xcframework.zip",
            checksum: "1e0329af37acde28baff3e31e1b05ec0e36735776b6890330829d756077c9ed9"
        ),
        .binaryTarget(
            name: "BideaseCore",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.0/BideaseCore.xcframework.zip",
            checksum: "fac77623196cb0bedf8df80c9acb89d4645d8f5062fcd47cde565e53125bd4ab"
        ),
        .binaryTarget(
            name: "BideaseAdapterAdmob",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.0/BideaseAdapterAdmob.xcframework.zip",
            checksum: "63354c28179d94fb22eda677fbc0bb9e49d89d90fbc9ddb9ca73aa4f3c547116"
        ),
        .binaryTarget(
            name: "BideaseAdapterGAM",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.0/BideaseAdapterGAM.xcframework.zip",
            checksum: "e6eb579eb0c4590e604a643e8a652dd651a6f443557263fd318448431f0faf63"
        ),
        .binaryTarget(
            name: "BideaseAdapterAppLovin",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.0/BideaseAdapterAppLovin.xcframework.zip",
            checksum: "32cd6cba3b44e533cfe7fd3ce3b8fa05b0f19eb8cc1ef100d9eb8488043bf296"
        ),
        .binaryTarget(
            name: "BideaseMobileTestMode",
            url: "https://github.com/bidease/BideaseSDK-iOS/releases/download/3.0.0/BideaseMobileTestMode.xcframework.zip",
            checksum: "0e61bde7fdebdeda409d14ea907508185a002de35f490435c6b36bd71f05da67"
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
