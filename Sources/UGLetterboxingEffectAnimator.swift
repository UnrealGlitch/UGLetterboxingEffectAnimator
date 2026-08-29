//
//  UGLetterboxingEffectAnimator.swift
//  UGLetterboxingEffectAnimator
//
//  Created by UnrealGlitch on 28.08.2026.
//

import UIKit

/// Animation of a screen shrinking from the top and bottom. Two black cinematic stripes smoothly slide toward the center, but don't quite reach it (cinema effect).
/// # Usage example
///
/// ## Initialization
/// **view** - The view to which visual elements will be added.
///
/// **isLeavingAnimation** - A flag that sets the initial position of the cinematic lines. **True** - If you want the lines to be initially visible. **False** - If you want the lines to be off-screen.
///
/// **subviewBackgroundColor** - The color of the subview bars.
///
/// **subviewBorderColor** - The border color of the subview bars.
///
/// **screenWidth** - The width of the screen.
///
/// - Note: screenWidth is passed in if the view's dimensions are not yet known.
///
/// **padding** - Padding from the edge of the screen to the maximum edge of the bar.
///
/// **alpha** - The tilt angle of the plate.
///
/// ``` swift
///
/// let movieScreenAnimator = UGLetterboxingEffectAnimator(
///     on: view,
///     inputData: UGLetterboxingEffectInputData(
///         isLeavingAnimation: true,
///         subviewBackgroundColor: UIColor.black,
///         subviewBorderColor: UIColor.white.cgColor,
///         screenWidth: 300,
///         padding: 120,
///         alpha: 10
///     )
/// )
///
/// ```
///
/// ## Animation
///
/// Tracking which direction the animation moves is done automatically and depends on the initial isLeavingAnimation parameter.
///
/// ``` swift
///
/// animator?.animate()
///
/// ```
@MainActor
public final class UGLetterboxingEffectAnimator {

    // MARK: - Life cycle

    /// Initializer.
    /// - Parameter view: The view on which to perform the animation.
    /// - Parameter inputData: Input data.
    /// ## Input data
    /// **isLeavingAnimation** - A flag that sets the initial position of the cinematic lines. **True** - If you want the lines to be initially visible. **False** - If you want the lines to be off-screen.
    ///
    /// **subviewBackgroundColor** - The color of the subview bars.
    ///
    /// **subviewBorderColor** - The border color of the subview bars.
    ///
    /// **screenWidth** - The width of the screen.
    ///
    /// - Note: screenWidth is passed in if the view's dimensions are not yet known.
    ///
    /// **padding** - Padding from the edge of the screen to the maximum edge of the bar.
    ///
    /// **alpha** - The tilt angle of the plate.
    public init(on view: UIView, inputData: UGLetterboxingEffectInputData) {
        self.view = view
        self.inputData = inputData
        self.isLeavingAnimationActualState = inputData.isLeavingAnimation

        configureUI(on: view)
        configureConstraints(on: view)
    }

    /// Deinitializer.
    deinit {
        print("UGLetterboxingEffectAnimator was deinitialized")
    }

    // MARK: - Public functions

    /// Start animation.
    /// - Note: Tracking the direction of the animation is automatic and depends on the initial isLeavingAnimation parameter.
    public func animate() {
        guard let view, !isAnimating else {
            return
        }

        isAnimating.toggle()
        setViews(hidden: false)

        UIView.animate(
            withDuration: Constants.animationDuration,
            animations: { [weak self] in
                guard let self else {
                    return
                }

                if self.isLeavingAnimationActualState {
                    self.topConstraint?.constant = self.topViewOutValue
                    self.bottomConstraint?.constant = self.bottomViewOutValue
                } else {
                    self.topConstraint?.constant = self.topViewInValue
                    self.bottomConstraint?.constant = self.bottomViewInValue
                }

                view.setNeedsLayout()
                view.layoutIfNeeded()
            },
            completion: { [weak self] _ in
                guard let self else {
                    return
                }

                self.setViews(hidden: self.isLeavingAnimationActualState)

                self.isLeavingAnimationActualState.toggle()
                self.isAnimating.toggle()
            }
        )
    }

    // MARK: - Private enums

    /// Constants.
    private enum Constants {
        /// Border width.
        static let borderWidth: CGFloat = 3

        /// Pivot point for bars.
        /// - Note: Rotation is based on the lower left corner.
        static let anchorPoint = CGPoint(x: 0, y: 1)

        /// Fast animation time.
        static let animationDuration: TimeInterval = 0.5
    }

    // MARK: - Private properties

    /// Input data.
    private let inputData: UGLetterboxingEffectInputData

    /// Animation presence flag.
    /// - Note: Prevents the animation from running multiple times until the old animation completes.
    private var isAnimating = false

    /// Animation type flag. **True** - if the stripes should already be visible and will extend beyond the screen. **False** - if the stripes extend from beyond the screen toward the center.
    private var isLeavingAnimationActualState: Bool

    /// Top indent of the top plate.
    private var topConstraint: NSLayoutConstraint?

    /// Bottom indent of the top plate.
    private var bottomConstraint: NSLayoutConstraint?

    // MARK: - Private weak properties

    /// The main view where animations occur.
    private weak var view: UIView?

    // MARK: - Private lazy properties

    /// Upper plate.
    private lazy var topView: UIView = {
        let view = UIView()

        view.backgroundColor = inputData.subviewBackgroundColor
        view.layer.borderColor = inputData.subviewBorderColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.anchorPoint = Constants.anchorPoint

        return view
    }()

    /// Bottom plate.
    private lazy var bottomView: UIView = {
        let view = UIView()

        view.backgroundColor = inputData.subviewBackgroundColor
        view.layer.borderColor = inputData.subviewBorderColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.anchorPoint = Constants.anchorPoint

        return view
    }()

    /// Height of the plate.
    private lazy var height: CGFloat = {
        inputData.padding * cos(inputData.alpha)
    }()

    /// Width of the plate.
    private lazy var width: CGFloat = {
        cos(inputData.alpha) * inputData.screenWidth + sin(inputData.alpha) * inputData.padding
    }()

    /// The limit value for the position of the top bar outside the screen.
    private lazy var topViewOutValue: CGFloat = {
        -height / 2
    }()

    /// The limit value for the position of the top bar within the screen.
    private lazy var topViewInValue: CGFloat = {
        height / 2
    }()

    /// The limit value for the position of the bottom bar outside the screen.
    private lazy var bottomViewOutValue: CGFloat = {
        2 * height - sin(inputData.alpha) * width
    }()

    /// The limit value for the position of the top bar within the screen.
    private lazy var bottomViewInValue: CGFloat = {
        (width - inputData.screenWidth / cos(inputData.alpha)) / sin(inputData.alpha)
    }()

}

// MARK: - Private functions

private extension UGLetterboxingEffectAnimator {

    /// Set the visibility of the bars.
    /// - Parameter hidden: Visibility flag.
    func setViews(hidden: Bool) {
        topView.isHidden = hidden
        bottomView.isHidden = hidden
    }

    /// View configuration.
    /// - Parameter view: The view to which the stripes should be added and the animation performed.
    func configureUI(on view: UIView) {
        view.addSubview(topView)
        view.addSubview(bottomView)
    }

    /// Layout.
    /// - Parameter view: The view to which the stripes should be added and the animation performed.
    func configureConstraints(on view: UIView) {
        // Shift by Constants.borderWidth so the left side of the border isn't visible
        topView.prepareForAutoLayout()
            .pin(height: height)
            .pin(width: width)
            .pinLeft(constraintValue: -width / 2 - Constants.borderWidth)

        let offset = inputData.screenWidth - cos(inputData.alpha) * (width - inputData.padding * sin(inputData.alpha))

        // Shift by Constants.borderWidth so the right side of the border isn't visible
        bottomView.prepareForAutoLayout()
            .pin(height: height)
            .pin(width: width)
            .pinLeft(
                constraintValue: -width / 2 + Constants.borderWidth + offset
            )

        if inputData.isLeavingAnimation {
            topConstraint = topView.pinTop(toTop: view, constraintValue: topViewInValue)
            bottomConstraint = bottomView.pinBottom(toBottom: view, constraintValue: bottomViewInValue)
        } else {
            topConstraint = topView.pinTop(toTop: view, constraintValue: topViewOutValue)
            bottomConstraint = bottomView.pinBottom(toBottom: view, constraintValue: bottomViewOutValue)
        }

        topView.transform = CGAffineTransformMakeRotation(-inputData.alpha)
        bottomView.transform = CGAffineTransformMakeRotation(-inputData.alpha)
    }

}
