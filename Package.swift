// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

internal let kPackage = Package(
    name: "UGLetterboxingEffectAnimator",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "UGLetterboxingEffectAnimator",
            targets: ["UGLetterboxingEffectAnimator"]
        )
    ],
    targets: [
        .target(
            name: "UGLetterboxingEffectAnimator"
        )
    ],
    swiftLanguageModes: [.v5]
)
