//
//  UGLetterboxingEffectInputData.swift
//  UGLetterboxingEffectAnimator
//
//  Created by UnrealGlitch on 28.08.2026.
//

import UIKit

/// Input data for the UGLetterboxingEffectAnimator class for initialization.
public struct UGLetterboxingEffectInputData {

    // MARK: - Life cycle

    /// Initializer.
    /// - Parameters:
    ///  - isLeavingAnimation: Animation type flag. **True** - if the stripes should already be visible and will extend off-screen. **False** - if the stripes extend from off-screen toward the center.
    ///  - subviewBackgroundColor: Stripe color.
    ///  - subviewBorderColor: Stripe border color.
    ///  - screenWidth: Screen width.
    ///  - padding: Padding from the edge of the screen to the maximum edge of the bar.
    ///  - alpha: The tilt angle of the plate.
    /// - Note: screenWidth is passed in case the view's dimensions are not yet known.
    public init(
        isLeavingAnimation: Bool,
        subviewBackgroundColor: UIColor,
        subviewBorderColor: CGColor,
        screenWidth: CGFloat,
        padding: CGFloat,
        alpha: Int
    ) {
        self.isLeavingAnimation = isLeavingAnimation
        self.subviewBackgroundColor = subviewBackgroundColor
        self.subviewBorderColor = subviewBorderColor
        self.screenWidth = screenWidth
        self.padding = padding
        self.alpha = CGFloat(alpha) * .pi / 180
    }

    // MARK: - Internal properties

    /// Animation type flag. **True** - if the bars should already be visible and will extend beyond the screen. **False** - if the bars extend from the edges of the screen toward the center.
    internal let isLeavingAnimation: Bool

    /// Bar color.
    internal let subviewBackgroundColor: UIColor

    /// Bar border color.
    internal let subviewBorderColor: CGColor

    /// Screen width.
    internal let screenWidth: CGFloat

    /// Padding from the edge of the screen to the maximum edge of the bar.
    internal let padding: CGFloat

    /// The tilt angle of the plate.
    internal let alpha: CGFloat

}
