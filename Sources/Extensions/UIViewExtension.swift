//
//  UIViewExtension.swift
//  UGLetterboxingEffectAnimator
//
//  Created by UnrealGlitch on 10.09.2025.
//

import UIKit

/// Extended view manipulation for simplified layout.
extension UIView {

    /// Prepares UIView for manual layout.
    /// - Returns: The updated view.
    @discardableResult
    internal func prepareForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    /// Anchors to the left edge of the parent view.
    /// - Parameter constraintValue: Indent.
    /// - Returns: The updated view.
    @discardableResult
    internal func pinLeft(constraintValue: CGFloat = 0) -> Self {
        guard let parentView = superview else {
            return self
        }
        leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: constraintValue).isActive = true
        return self
    }

    /// Sets the view width.
    /// - Parameter width: Width.
    /// - Returns: The updated view.
    @discardableResult
    internal func pin(width: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }

    /// Set the view's height.
    /// - Parameter height: Height.
    /// - Returns: The updated view.
    @discardableResult
    internal func pin(height: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }

    /// Anchor to the top edge of a specific view.
    /// - Parameters:
    ///  - secondView: The view to anchor to.
    ///  - constraintValue: Offset.
    /// - Returns: The topAnchor constraint.
    @discardableResult
    internal func pinTop(
        toTop secondView: UIView,
        constraintValue: CGFloat = 0
    ) -> NSLayoutConstraint {
        let constraint = topAnchor.constraint(
            equalTo: secondView.topAnchor,
            constant: constraintValue
        )
        constraint.isActive = true
        return constraint
    }

    /// Anchor to the bottom edge of a specific view.
    /// - Parameters:
    ///  - secondView: The view to anchor to.
    ///  - constraintValue: Offset.
    /// - Returns: The bottomAnchor constraint.
    @discardableResult
    internal func pinBottom(
        toBottom secondView: UIView,
        constraintValue: CGFloat = 0
    ) -> NSLayoutConstraint {
        let constraint = bottomAnchor.constraint(
            equalTo: secondView.bottomAnchor,
            constant: constraintValue
        )
        constraint.isActive = true
        return constraint
    }

}
