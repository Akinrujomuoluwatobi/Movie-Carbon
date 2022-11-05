//
//  ViewController.swift
//

import UIKit
import RxRelay

protocol FlowBreakableViewController {
  var isBreakableFlowViewController: Bool { get set }
  var userConfirmedFlowBreakAction: (() -> Void)? { get set }
  var requestBreakProcessAction: (() -> Void)? { get set }
}

class ViewController<CustomView: View>: UIViewController, UIGestureRecognizerDelegate, FlowBreakableViewController {
  
  var rxViewDidLoad = BehaviorRelay(value: false)
  
  var rxViewAppear = BehaviorRelay(value: false)
  
  var onViewDidAppear: (() -> Void)?
  
  var requestBreakProcessAction: (() -> Void)?
  
  var userConfirmedFlowBreakAction: (() -> Void)?
  
  var isBreakableFlowViewController = false
  
  let customView: CustomView
  
  init(view: CustomView) {
    self.customView = view
    super.init(nibName: nil, bundle: nil)
    modalPresentationStyle = .fullScreen
    
    requestBreakProcessAction = { [weak self] in
			self?.userConfirmedFlowBreakAction?()
//      self?.question(
//        message: "You are going to abandon the process. Are you sure?",
//        title: "Attention",
//        confirmationHandler: {  [weak self] in
//          self?.userConfirmedFlowBreakAction?()
//        }
//      )
    }
    preloadData()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// - SeeAlso: UIViewController.loadView()
  override func loadView() {
    view = customView
    view.clipsToBounds = true
  }
  
//  func setupNavigationBarAppearance() {
//    navigationController?.navigationBar.titleTextAttributes = [
//      .foregroundColor: UIColor.black,
//      .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
//    ]
//    guard
//      let navigationController = navigationController,
//      navigationController.viewControllers.count > 1
//    else {
//      return
//    }
//
//    let customBackButtonItemView = CustomBackButtonItemView()
//    customBackButtonItemView.addTarget(self, action: #selector(backButtonItemAction), for: .touchUpInside)
//
//    let leftBarButtonItem = UIBarButtonItem(customView: customBackButtonItemView)
//
//    navigationItem.leftBarButtonItem = leftBarButtonItem
//
//    /// Need to be set for interactive gesture - otherwise it doesn't work properly.
//    navigationController.interactivePopGestureRecognizer?.delegate = self
//  }
  
  @objc private func backButtonItemAction() {
    navigationController?.popViewController(animated: true)
  }
  
  /// - SeeAlso: UIViewController.viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    //setupNavigationBarAppearance()
    setupProperties()
    setupCallbacks()
    setupBehaviour()
    rxViewDidLoad.accept(true)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    onViewDidAppear?()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  /// Called automatically on `init()`. Here is possible to start doing some not UI related processing.
  func preloadData() {
    // no-op by default
  }
  
  /// Sets up the properties of `self`. Called automatically on `viewDidLoad()`.
  func setupProperties() {
    // no-op by default
  }
  
  /// Sets up callbacks in `self`. Called automatically on `viewDidLoad()`.
  func setupCallbacks() {
    // no-op by default
  }
  
  /// Sets up behaviour in `self`. Called automatically on `viewDidLoad()`.
  func setupBehaviour() {
    // no-op by default
  }
  
//  deinit {
//    LOGGER.d("Deinitialized: \(type(of: self))")
//  }
}
