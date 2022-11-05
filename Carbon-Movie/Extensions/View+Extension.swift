//
//  View+Extension.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import UIKit

extension UIView {
	
	/// Anchor of the view.
	enum Anchor {
		case top
		case right
		case bottom
		case left
	}
	
	/// Constraint edges of the view to its superview edges.
	///
	/// - Parameters:
	///   - excludingAnchors: Anchros that shouldn't be constraint.
	///   - insets: Insets to use, .zero by default.
	/// - Returns: Created constraints.
	@discardableResult func constraintToSuperviewEdges(excludingAnchors: [Anchor]? = nil, withInsets insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
		guard let superview = superview else {
			fatalError("Cannot constrain to nil superview")
		}
		return constraintToEdges(of: superview, excludingAnchors: excludingAnchors, withInsets: insets)
	}
	//
	/// Constraint edges of the view to given view edges.
	///
	/// - Parameters:
	///   - view: View to constraint edges to.
	///   - excludingAnchors: Anchros that shouldn't be constraint.
	///   - insets: Insets to use, .zero by default.
	/// - Returns: Created constraints.
	@discardableResult func constraintToEdges(of view: UIView, excludingAnchors: [Anchor]? = nil, withInsets insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		if let excludedAnchors = excludingAnchors {
			if !excludedAnchors.contains(.top) { constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)) }
			if !excludedAnchors.contains(.right) { constraints.append(rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right)) }
			if !excludedAnchors.contains(.bottom) { constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)) }
			if !excludedAnchors.contains(.left) { constraints.append(leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left)) }
		} else {
			constraints = [
				topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
				leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
				rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
				bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
			]
		}
		NSLayoutConstraint.activate(constraints)
		return constraints
	}
	
	/// Constraint edges of the view to its superview layout guide.
	///
	/// - Parameters:
	///   - excludingAnchors: Anchros that shouldn't be constraint.
	///   - insets: Insets to use, .zero by default.
	/// - Returns: Created constraints.
	@discardableResult func constraintToSuperviewLayoutGuide(excludingAnchors: [Anchor]? = nil, withInsets insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
		guard let superview = superview else {
			fatalError("Cannot constrain to nil superview")
		}
		return constraintToLayoutGuide(of: superview, excludingAnchors: excludingAnchors, withInsets: insets)
	}
	
	/// Constraint edges of the view to given view layout guide.
	///
	/// - Parameters:
	///   - view: View to constraint edges to.
	///   - excludingAnchors: Anchros that shouldn't be constraint.
	///   - insets: Insets to use, .zero by default.
	/// - Returns: Created constraints.
	@discardableResult func constraintToLayoutGuide(of view: UIView, excludingAnchors: [Anchor]? = nil, withInsets insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		if #available(iOS 11.0, *) {
			let layoutGuide = view.safeAreaLayoutGuide
			if let excludedAnchors = excludingAnchors {
				if !excludedAnchors.contains(.top) { constraints.append(topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top)) }
				if !excludedAnchors.contains(.right) { constraints.append(rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right)) }
				if !excludedAnchors.contains(.bottom) { constraints.append(bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)) }
				if !excludedAnchors.contains(.left) { constraints.append(leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left)) }
			} else {
				constraints = [
					topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top),
					leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left),
					rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right),
					bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
				]
			}
			NSLayoutConstraint.activate(constraints)
			return constraints
		} else {
			return []
		}
	}
	
	/// Constraint center of the view to the superview center.
	///
	/// - Parameters:
	///   - axis: Axis that should be constraint.
	///   - constant: Constant value to use for constraining.
	/// - Returns: Created constraints.
	@discardableResult func constraintCenterToSuperview(axis: [NSLayoutConstraint.Axis] = [.horizontal, .vertical], withConstant constant: CGPoint = .zero) -> [NSLayoutConstraint] {
		guard let superview = superview else {
			fatalError("Cannot constrain to nil superview")
		}
		return constraintCenter(to: superview, axis: axis, withConstant: constant)
	}
	
	/// Constraint center the view to the given view center
	///
	/// - Parameters:
	///   - view: View to constraint center to
	///   - axis: Axis that should be constraint
	///   - constant: Constant value to use for constraining
	/// - Returns: Created constraints
	@discardableResult func constraintCenter(to view: UIView, axis: [NSLayoutConstraint.Axis] = [.horizontal, .vertical], withConstant constant: CGPoint = .zero) -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()
		if axis.contains(.horizontal) { constraints.append(centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant.x)) }
		if axis.contains(.vertical) { constraints.append(centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant.y)) }
		NSLayoutConstraint.activate(constraints)
		return constraints
	}
	
	/// Constraints width and height anchors to the given constant size
	///
	/// - Parameter size: Size to get values from
	/// - Returns: Created constraints
	@discardableResult func constraintToConstant(_ size: CGSize) -> [NSLayoutConstraint] {
		let constraints = [
			widthAnchor.constraint(equalToConstant: size.width),
			heightAnchor.constraint(equalToConstant: size.height)
		]
		NSLayoutConstraint.activate(constraints)
		return constraints
	}
	
	/// Returns view with the same type that can be used with AutoLayout
	///
	/// - Returns: Adjusted view
	func layoutable() -> Self {
		translatesAutoresizingMaskIntoConstraints = false
		return self
	}
	
	/// Returns view with provided corner radius
	///
	/// - Returns: Adjusted view
	func withCornerRadius(_ radius: CGFloat) -> Self {
		layer.cornerRadius = radius
		layer.masksToBounds = true
		return self
	}
	
	/// Add shake animation to UIView
	func shake() {
		self.transform = CGAffineTransform(translationX: 20, y: 0)
		UIView.animate(
			withDuration: 0.4,
			delay: 0,
			usingSpringWithDamping: 0.2,
			initialSpringVelocity: 1,
			options: .curveEaseInOut,
			animations: {
				self.transform = CGAffineTransform.identity
			},
			completion: nil
		)
	}
	
	/// Convenience method allowing to add an array of subviews.
	/// - Parameter subviews: array of UIView elements that should be added to a superview.
	func addSubviews(_ subviews: [UIView]) {
		subviews.forEach(addSubview)
	}
	
	/// Return the first view in subviews
	func firstSubView<T: UIView>(ofType type: T.Type) -> T? {
		var resultView: T?
		for view in subviews {
			if let view = view as? T {
				resultView = view
				break
			} else {
				if let foundView = view.firstSubView(ofType: T.self) {
					resultView = foundView
					break
				}
			}
		}
		return resultView
	}
}

extension UIView {
	
	func edges(_ edges: UIRectEdge, to view: UIView, offset: UIEdgeInsets) {
		self.translatesAutoresizingMaskIntoConstraints = false
		if edges.contains(.top) || edges.contains(.all) {
			self.topAnchor.constraint(equalTo: view.topAnchor, constant: offset.top).isActive = true
		}
		
		if edges.contains(.bottom) || edges.contains(.all) {
			self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.bottom).isActive = true
		}
		
		if edges.contains(.left) || edges.contains(.all) {
			self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.left).isActive = true
		}
		
		if edges.contains(.right) || edges.contains(.all) {
			self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.right).isActive = true
		}
	}
	
	func center(in view: UIView, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
		self.translatesAutoresizingMaskIntoConstraints = false
		centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xOffset).isActive = true
		centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yOffset).isActive = true
	}
	
	func centerAlignRight(in view: UIView, offset: CGFloat = 0.0) {
		centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		anchor(
			top: nil,
			leading: nil,
			bottom: nil,
			trailing: view.trailingAnchor,
			padding: .init(top: 0, left: 0, bottom: 0, right: offset)
		)
	}
	
	func fillSuperView(with margin: UIEdgeInsets = .zero) {
		anchor(
			top: superview?.safeAreaLayoutGuide.topAnchor,
			leading: superview?.safeAreaLayoutGuide.leadingAnchor,
			bottom: superview?.safeAreaLayoutGuide.bottomAnchor,
			trailing: superview?.safeAreaLayoutGuide.trailingAnchor,
			padding: margin
		)
	}
	
	func anchorSize(to view: UIView) {
		widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
	}
	
	func anchor(
		top: NSLayoutYAxisAnchor? = nil,
		leading: NSLayoutXAxisAnchor? = nil,
		bottom: NSLayoutYAxisAnchor? = nil,
		trailing: NSLayoutXAxisAnchor? = nil,
		padding: UIEdgeInsets = .zero,
		size: CGSize = .zero
	) {
		translatesAutoresizingMaskIntoConstraints = false
		
		if let top = top {
			topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
		}
		
		if let leading = leading {
			leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
		}
		
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
		}
		
		if let trailing = trailing {
			trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
		}
		
		if size.width != 0 {
			widthAnchor.constraint(equalToConstant: size.width).isActive = true
		}
		
		if size.height != 0 {
			heightAnchor.constraint(equalToConstant: size.height).isActive = true
		}
		
	}
	
	func size(to size: CGSize) {
		translatesAutoresizingMaskIntoConstraints = false
		
		if size.width != 0 {
			widthAnchor.constraint(equalToConstant: size.width).isActive = true
		}
		
		if size.height != 0 {
			heightAnchor.constraint(equalToConstant: size.height).isActive = true
		}
	}
	
	func addBorder(borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: UIColor) {
		layer.borderWidth = borderWidth
		layer.borderColor = borderColor.cgColor
		layer.cornerRadius = cornerRadius
		layer.masksToBounds = true
	}
	
	func applyCornerRadius(radius: CGFloat = 5.0, borderColor: UIColor = .gray) {
		layer.borderWidth = 1.0
		layer.borderColor = borderColor.cgColor
		layer.cornerRadius = radius
	}
	
	func removeBorder() {
		layer.borderWidth = 0.0
		layer.borderColor = nil
		layer.cornerRadius = 0.0
	}
	
	func addShadow(color: UIColor, opacity: Float, shadowOffset: CGSize, blur: CGFloat) {
		layer.shadowColor = color.cgColor
		layer.shadowOpacity = opacity
		layer.shadowOffset = shadowOffset
		layer.shadowRadius = blur / 2
	}
	
	func removeShadow() {
		layer.shadowColor = UIColor.white.cgColor
		layer.shadowOpacity = 0
		layer.shadowOffset = CGSize.zero
		layer.shadowRadius = 0
		layer.shadowPath = nil
	}
}

extension NSObject {
	
	/// Returns class name stripped from module name.
	class var className: String {
		let namespaceClassName = String(describing: self)
		return namespaceClassName.components(separatedBy: ".").last!
	}
}
