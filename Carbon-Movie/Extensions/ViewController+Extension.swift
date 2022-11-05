//
//  ViewController+Extension.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import UIKit
extension UIViewController {
	func bottomAlert(
		title: String,
		subtitle: String? = nil,
		primaryButtonTitle: String?,
		normalButtonTitle: String? = nil,
		description: String,
		primaryCompletionHandler: (() -> Void)? = nil,
		normalCompletionHandler: (() -> Void)? = nil) {
			let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
				switch action.style{
					case .default:
						primaryCompletionHandler?()
						
					case .cancel:
						normalCompletionHandler?()
						
					case .destructive:
						print("destructive")
						
				}
			}))
			self.present(alert, animated: true, completion: nil)
		}
}
