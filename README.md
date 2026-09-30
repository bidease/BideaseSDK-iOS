# Bidease Mobile SDK — Swift Package

Swift Package Manager distribution of the Bidease Mobile SDK for iOS.
The contents of this repository are generated on each SDK release — do not send pull requests here.

- **Version:** `3.0.0`
- **Requires:** iOS 13.0+, Xcode 15+
- Also available via [CocoaPods](https://cocoapods.org/pods/BideaseSDK) (`pod 'BideaseSDK'`).

## Installation

In Xcode: **File → Add Package Dependencies…** and enter

```
https://github.com/bidease/BideaseSDK-iOS
```

Or in a `Package.swift`. Note that `package:` is the repository name — SwiftPM identifies a
dependency by the last component of its URL, not by the name inside its manifest:

```swift
dependencies: [
    .package(url: "https://github.com/bidease/BideaseSDK-iOS", from: "3.0.0")
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "BideaseSDK", package: "BideaseSDK-iOS"),
    ])
]
```

## Products

Pick the products you need — they map 1:1 to the CocoaPods subspecs.

| Product | CocoaPods subspec | Contains |
|---|---|---|
| `BideaseSDK` | `BideaseSDK/MobileAds` | Core SDK — required by every adapter |
| `BideaseSDKAdapterAdmob` | `BideaseSDK/AdapterAdmob` | AdMob mediation adapter (pulls Google Mobile Ads) |
| `BideaseSDKAdapterGAM` | `BideaseSDK/AdapterGAM` | Google Ad Manager adapter (pulls Google Mobile Ads) |
| `BideaseSDKAdapterAppLovinMax` | `BideaseSDK/AdapterAppLovinMax` | AppLovin MAX adapter (pulls AppLovinSDK) |
| `BideaseSDKTestMode` | `BideaseSDK/TestMode` | Test-mode helper — do not ship in production builds |

`BideaseSDKAdapterAdmob` and `BideaseSDKAdapterGAM` share their adapter class, so pick one —
linking both fails with duplicate symbols (the CocoaPods subspecs behave the same way).

Import names are unchanged from CocoaPods:

```swift
import BideaseMobileSDK
```

## Required: add `-ObjC` to your app target

**This step is not optional.** The SDK and its adapters are static frameworks that register
Objective-C classes and categories which nothing references at compile time — the mediation
adapters in particular are instantiated by class name at runtime. Without `-ObjC` the linker
drops them and you get no ads, or a crash on first load.

In your **app target** → **Build Settings** → **Other Linker Flags** (`OTHER_LDFLAGS`), add:

```
-ObjC
```

The CocoaPods integration sets this for you via `user_target_xcconfig`. Swift Package Manager
has no equivalent — it rejects linker flags in versioned package dependencies — so it has to be
set by hand. (AppLovin's own Swift package carries the same caveat.)

## Third-party dependencies

Resolving this package also resolves the Google Mobile Ads and AppLovin Swift packages, because
the adapter products depend on them. Only the products you actually add to a target are linked
into your app.

| Dependency | Version range |
|---|---|
| [swift-package-manager-google-mobile-ads](https://github.com/googleads/swift-package-manager-google-mobile-ads) | `12.0.0 ..< 14.0.0` |
| [AppLovin-MAX-Swift-Package](https://github.com/AppLovin/AppLovin-MAX-Swift-Package) | `13.0.0 ..< 14.0.0` |

## Migrating from CocoaPods

1. Remove `pod 'BideaseSDK'` (and its subspecs) from the `Podfile`, run `pod install`.
2. Add the Swift package as above and select the matching products.
3. Keep or add `-ObjC` in the app target's **Other Linker Flags** — CocoaPods used to inject it.
4. No source changes: module names and APIs are identical.

## Support

be-sdk@bidease.com
