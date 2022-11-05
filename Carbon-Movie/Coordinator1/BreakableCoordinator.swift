//
//  BreakableCoordinator.swift
//
//  This protocol is used to define default logic when user tries to get out from view which doing some processing,
//  so leaving this view would create some integration issues etc.
//
//  Just call `setupBreakableFlow()` in `start()` method and operate `isBreakableFlowViewController` variable on `ViewController` class.
//

import UIKit

protocol BreakableCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}

extension BreakableCoordinator {

    func setupBreakableFlow() {
        resetFlowRequest = { [weak self] in
            guard var controller = self?.navigationController.visibleViewController as? FlowBreakableViewController, controller.isBreakableFlowViewController else {
                self?.resetFlowResponse?()
                return
            }
            controller.userConfirmedFlowBreakAction = { [weak self] in
                self?.resetFlow()
                self?.resetFlowResponse?()
            }
            controller.requestBreakProcessAction?()
        }

        isCurrentViewControllerProcessBreaking = { [weak self] in
            return (self?.navigationController.visibleViewController as? FlowBreakableViewController)?.isBreakableFlowViewController ?? (false)
        }
    }

    private func resetFlow() {
        navigationController.popToRootViewController(animated: false)
    }
}
