//
//  LoadablePresenter.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import SVProgressHUD

protocol LoadablePresenter: DisposeBagContainer {
	var isLoading: BehaviorRelay<Bool> { get }
}

protocol DisposeBagContainer: AnyObject {
	var disposeBag: DisposeBag { get }
}

protocol LoadablePresenterContainer: DisposeBagContainer {
	var loadablePresenter: LoadablePresenter { get }
}

extension LoadablePresenterContainer where Self: UIViewController {
	
	func subscribeOnLoading() {
		loadablePresenter.isLoading
			.asObservable()
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { [weak self] isLoading in
				guard let self = self else { return }
				if isLoading {
					SVProgressHUD.show()
					self.view.isUserInteractionEnabled = false
				} else {
					SVProgressHUD.dismiss()
					self.view.isUserInteractionEnabled = true
				}
			}).disposed(by: self.disposeBag)
	}
}

extension LoadablePresenterContainer where Self: UIView {
	
	func subscribeOnLoading(_ superView: UIView) {
		loadablePresenter.isLoading
			.asObservable()
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { isLoading in
				if isLoading {
					SVProgressHUD.show()
					superView.isUserInteractionEnabled = false
				} else {
					SVProgressHUD.dismiss()
					superView.isUserInteractionEnabled = true
				}
			}).disposed(by: self.disposeBag)
	}
}
