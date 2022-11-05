//
//  ViewControllerRoutes.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import UIKit

protocol ViewControllerRoutes: AnyObject {
	var viewController: UIViewController { get }
	var onViewDidAppear: (() -> Void)? { get set }
}

extension ViewControllerRoutes where Self: UIViewController {
	
	var viewController: UIViewController {
		return self
	}
}

extension ViewControllerRoutes {
	/// Set this variable to true, If you want to ask user if he really wants to leave current view using tabBarController.
	/// If he agree all flow in current navigation controller will be reseted to the root view controller.
	/// See MainCoordinator for details.
	var processBreakableViewController: Bool {
		get {
			return (viewController as? FlowBreakableViewController)?.isBreakableFlowViewController ?? false
		}
		set {
			var controller: FlowBreakableViewController? = viewController as? FlowBreakableViewController
			controller?.isBreakableFlowViewController = newValue
		}
	}
	
	func removeBackButton() {
		viewController.navigationItem.leftBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
	}
}
