//

import Foundation
import UIKit

extension UIView {
    ///
    /// Uses AutoLayout to create constraints that will fill the receiver's superview, optionally using the specified padding
    ///
    /// - parameters:
    ///     - padding: Used to add outer spacing between the receiver and it's superview
    ///
    /// - returns:
    ///     The generated constraints in a named list
    ///
    @discardableResult
    func constraintFillSuperview(padding: CGFloat = 0) -> (topConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint, leftConstraint: NSLayoutConstraint)? {
        guard let superview = self.superview else {
            return nil
        }

        let topAnchor = self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding)
        let rightAnchor = superview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding)
        let bottomAnchor = superview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: padding)
        let leftAnchor = self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: padding)

        topAnchor.isActive = true
        rightAnchor.isActive = true
        bottomAnchor.isActive = true
        leftAnchor.isActive = true

        return (topAnchor, rightAnchor, bottomAnchor, leftAnchor)
    }

    ///
    /// Uses AutoLayout to create constraints that will fill the receiver's superview keeping the safe area layout guide, optionally using the specified padding
    ///
    /// - parameters:
    ///     - padding: Used to add outer spacing between the receiver and it's superview
    ///
    /// - returns:
    ///     The generated constraints in a named list
    ///
    @discardableResult
    func constraintFillSuperviewSafeArea(padding: CGFloat = 0) -> (leftConstraint: NSLayoutConstraint, topConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint)? {
        guard let superview = self.superview else {
            return nil
        }

        let topConstraint = self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: padding)
        let rightConstraint = self.rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor, constant: padding)
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: padding)
        let leftConstraint = self.leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: padding)

        topConstraint.isActive = true
        rightConstraint.isActive = true
        bottomConstraint.isActive = true
        leftConstraint.isActive = true

        return (leftConstraint, topConstraint, rightConstraint, bottomConstraint)
    }

    ///
    /// Uses AutoLayout to center the receiver inside it's superview
    ///
    /// - parameters:
    ///     - xOffset: The offset the receiver will have from the X center line
    ///     - yOffset: The offset the receiver will have from the Y center line
    ///
    @discardableResult
    func constraintCenterInSuperView(centerX: Bool = false, xOffset: CGFloat = 0, centerY: Bool = false, yOffset: CGFloat = 0) -> (centerXConstraint: NSLayoutConstraint?, centerYConstraint: NSLayoutConstraint?)? {
        guard let superview = self.superview else {
            return nil
        }

        var centerXConstraint: NSLayoutConstraint?
        var centerYConstraint: NSLayoutConstraint?

        if centerX {
            centerXConstraint = self.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: xOffset)
        }

        if centerY {
            centerYConstraint = self.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: yOffset)
        }

        centerXConstraint?.isActive = true
        centerYConstraint?.isActive = true

        return (centerXConstraint, centerYConstraint)
    }

    ///
    /// Traverses the tree of views and removes every layout constraint containig the receiver
    ///
    public func removeAllConstraints(internalConstraints: Bool = true, useAutoresizingMask: Bool = true) {
        var _superview = self.superview

        while let superview = _superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            _superview = superview.superview
        }

        if internalConstraints { self.removeConstraints(self.constraints) }
        if useAutoresizingMask { self.translatesAutoresizingMaskIntoConstraints = true }
    }

    ///
    /// Uses AutoLayout to constraint the receiver to it's superview based on the received arguments
    ///
    /// - parameters:
    ///     - top: Sets weather the reciever will be constrained to it's superview top anchor
    ///     - left: Sets weather the reciever will be constrained to it's superview left anchor
    ///     - bottom: Sets weather the reciever will be constrained to it's superview bottom anchor
    ///     - right: Sets weather the reciever will be constrained to it's superview right anchor
    ///
    /// - returns:
    ///     A list of the optional `NSLayoutConstraint` values, representing the generated constraints
    ///
    @discardableResult
    public func constraintToSuperview(top: Bool = false, topPadding: CGFloat = 0, left: Bool = false, leftPadding: CGFloat = 0, bottom: Bool = false, bottomPadding: CGFloat = 0, right: Bool = false, rightPadding: CGFloat = 0) -> (topConstraint: NSLayoutConstraint?, leftConstraint: NSLayoutConstraint?, bottomConstraint: NSLayoutConstraint?, rightConstraint: NSLayoutConstraint?) {
        guard let superview = self.superview else {
            return (nil, nil, nil, nil)
        }

        var topConstraint: NSLayoutConstraint?
        var leftConstraint: NSLayoutConstraint?
        var bottomConstraint: NSLayoutConstraint?
        var rightConstraint: NSLayoutConstraint?

        if top {
            topConstraint = self.topAnchor.constraint(equalTo: superview.topAnchor, constant: topPadding)
            topConstraint?.isActive = true
        }

        if left {
            leftConstraint = self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leftPadding)
            leftConstraint?.isActive = true
        }

        if bottom {
            bottomConstraint = superview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding)
            bottomConstraint?.isActive = true
        }

        if right {
            rightConstraint = superview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: rightPadding)
            rightConstraint?.isActive = true
        }

        return (topConstraint, leftConstraint, bottomConstraint, rightConstraint)
    }

    ///
    /// Uses AutoLayout to constraint the receiver's dimensions
    ///
    /// - parameters:
    ///     width: The desired width the receiver should have
    ///     height: The desired height the receiver should have
    ///
    /// - returns:
    ///     A list of optional `NSLayoutConstraint` values representing the generated constraints
    ///
    @discardableResult
    public func constraintDimensions(width: CGFloat? = nil, height: CGFloat? = nil) -> (widthConstraint: NSLayoutConstraint?, heightConstraint: NSLayoutConstraint?) {
        var widthConstraint: NSLayoutConstraint?
        var heightConstraint: NSLayoutConstraint?

        if let width = width {
            widthConstraint = self.widthAnchor.constraint(equalToConstant: width)
            widthConstraint?.isActive = true
        }

        if let height = height {
            heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
            heightConstraint?.isActive = true
        }

        return (widthConstraint, heightConstraint)
    }

    @discardableResult
    public func constraintWrapSuperviewAround(top: Bool = false, topPadding: CGFloat = 0, trailing: Bool = false, trailingPadding: CGFloat = 0, bottom: Bool = false, bottomPadding: CGFloat = 0, leading: Bool = false, leadingPadding: CGFloat = 0) -> (top: NSLayoutConstraint?, trailiing: NSLayoutConstraint?, bottom: NSLayoutConstraint?, leading: NSLayoutConstraint?) {
        guard let superview = self.superview else {
            return (nil, nil, nil, nil)
        }

        var topConstraint: NSLayoutConstraint?
        var trailingConstraint: NSLayoutConstraint?
        var bottomConstraint: NSLayoutConstraint?
        var leadingConstraint: NSLayoutConstraint?

        if top {
            topConstraint = self.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor, constant: topPadding)
            topConstraint?.isActive = true
        }

        if trailing {
            trailingConstraint = superview.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: trailingPadding)
            trailingConstraint?.isActive = true
        }

        if bottom {
            bottomConstraint = superview.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: bottomPadding)
            bottomConstraint?.isActive = true
        }

        if leading {
            leadingConstraint = self.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: leadingPadding)
            leadingConstraint?.isActive = true
        }

        return (topConstraint, trailingConstraint, bottomConstraint, leadingConstraint)
    }

    @discardableResult
    public static func constraintVerticalSpacing(lowerView: UIView, higherView: UIView, spacing: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = lowerView.topAnchor.constraint(equalTo: higherView.bottomAnchor, constant: spacing)
        constraint.isActive = true

        return constraint
    }

    @discardableResult
    public static func constraintHorizontalSpacing(leadingView: UIView, trailingView: UIView, spacing: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = trailingView.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: spacing)
        constraint.isActive = true

        return constraint
    }

    @discardableResult
    public static func constraintCenter(anchorView: UIView, viewToCenter: UIView, centerX: Bool = false, offsetX: CGFloat = 0, centerY: Bool = false, offsetY: CGFloat = 0) -> (centerXConstraint: NSLayoutConstraint?, centerYConstraint: NSLayoutConstraint?) {
        var centerXConstraint: NSLayoutConstraint?
        var centerYConstraint: NSLayoutConstraint?

        if centerX {
            centerXConstraint = viewToCenter.centerXAnchor.constraint(equalTo: anchorView.centerXAnchor, constant: offsetX)
            centerXConstraint?.isActive = true
        }

        if centerY {
            centerYConstraint = viewToCenter.centerYAnchor.constraint(equalTo: anchorView.centerYAnchor, constant: offsetY)
            centerYConstraint?.isActive = true
        }

        return (centerXConstraint, centerYConstraint)
    }

    @discardableResult
    public static func constraintAlign(anchorView: UIView, viewToAlign: UIView, leading: Bool = false, leadingPadding: CGFloat = 0, top: Bool = false, topPadding: CGFloat = 0, trailing: Bool = false, trailingPadding: CGFloat = 0, bottom: Bool = false, bottomPadding: CGFloat = 0) -> (leadingConstraint: NSLayoutConstraint?, topConstraint: NSLayoutConstraint?, trailingConstraint: NSLayoutConstraint?, bottomConstraint: NSLayoutConstraint?) {
        var leadingConstraint: NSLayoutConstraint?
        var topConstraint: NSLayoutConstraint?
        var trailingConstraint: NSLayoutConstraint?
        var bottomConstraint: NSLayoutConstraint?

        if leading {
            leadingConstraint = viewToAlign.leadingAnchor.constraint(equalTo: anchorView.leadingAnchor, constant: leadingPadding)
            leadingConstraint?.isActive = true
        }

        if top {
            topConstraint = viewToAlign.topAnchor.constraint(equalTo: anchorView.topAnchor, constant: topPadding)
            topConstraint?.isActive = true
        }

        if trailing {
            trailingConstraint = viewToAlign.trailingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: trailingPadding)
            trailingConstraint?.isActive = true
        }

        if bottom {
            bottomConstraint = viewToAlign.bottomAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: bottomPadding)
            bottomConstraint?.isActive = true
        }

        return (leadingConstraint, topConstraint, trailingConstraint, bottomConstraint)
    }
}
