//
//  String+Extension.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import UIKit

extension NSMutableAttributedString {
	@discardableResult func first(_ text: String?,
																paragraphlineSpacing: CGFloat = 0,
																font: UIFont,
																textColor: UIColor,
																textAlignment: NSTextAlignment = .left,
																tabStops: [NSTextTab]? = nil
	) -> NSMutableAttributedString {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = paragraphlineSpacing
		paragraphStyle.alignment = textAlignment
		if tabStops != nil { paragraphStyle.tabStops = tabStops }
		
		let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: textColor, NSAttributedString.Key.paragraphStyle: paragraphStyle]
		let textString = NSMutableAttributedString(string: text ?? "", attributes: attrs)
		append(textString)
		
		return self
	}
	
	@discardableResult func next(_ text: String?,
															 paragraphlineSpacing: CGFloat = 0,
															 font: UIFont,
															 textColor: UIColor,
															 textAlignment: NSTextAlignment = .left,
															 tabStops: [NSTextTab]? = nil
	) -> NSMutableAttributedString {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = paragraphlineSpacing
		paragraphStyle.alignment = textAlignment
		if tabStops != nil { paragraphStyle.tabStops = tabStops }
		let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: textColor, NSAttributedString.Key.paragraphStyle: paragraphStyle]
		let textString = NSMutableAttributedString(string: text ?? "", attributes: attrs)
		append(textString)
		
		return self
	}
}
