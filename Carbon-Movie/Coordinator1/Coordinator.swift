//
//  Coordinator.swift
//

import Swinject
import RxSwift
import UIKit

protocol Coordinator: AnyObject {
    var rootViewController: UIViewController? { get }
    var resetFlowRequest: (() -> Void)? { get set }
    var resetFlowResponse: (() -> Void)? { get set }
    var isCurrentViewControllerProcessBreaking: (() -> Bool)? { get set }
    func stop(completionHandler: @escaping () -> Void)
    func process(action: CoordinatorAction?)
    func start()
}

class BaseCoordinator: NSObject, Coordinator {

    var rootViewController: UIViewController? {
        return nil
    }

    var resetFlowRequest: (() -> Void)?

    var resetFlowResponse: (() -> Void)?

    var isCurrentViewControllerProcessBreaking: (() -> Bool)?

    var childCoordinators: [Coordinator] = []

    let container: Container

    init(container: Container) {
        self.container = container
    }

    func start() {
        abstractMethod()
    }

    func stop(completionHandler: @escaping () -> Void) {
        let group = DispatchGroup()
        childCoordinators.forEach { coordinator in
            group.enter()
            coordinator.stop { [weak self] in
                self?.removeDependency(coordinator)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.performStop {
                completionHandler()
            }
        }
    }

    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else {
            return
        }
        for (index, element) in childCoordinators.enumerated() {
            guard element === coordinator else { return }
            childCoordinators.remove(at: index)
            break
        }
    }

    func performStop(completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func process(action: CoordinatorAction?) { }

    deinit {
        #if ENV_DEVELOPMENT
            print("Deinitialized: ", type(of: self))
        #endif
    }
}
