//
//  ErrorThrowablePresenter.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

protocol ErrorThrowablePresenter {
	var error: PublishSubject<Error> { get }
}

protocol ErrorThrowablePresenterContainer: DisposeBagContainer {
	var errorThrowablePresenter: ErrorThrowablePresenter { get }
}

extension ErrorThrowablePresenterContainer where Self: UIViewController {
	
	func subscribeOnAnyError(errorHandler: @escaping (() -> Void)) {
		errorThrowablePresenter.error
			.asObservable()
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { _ in
				errorHandler()
			}
			).disposed(by: disposeBag)
	}
	
	func subscribeOnErrors(completionHandler: ((Error) -> Void)? = nil) {
		errorThrowablePresenter
			.error
			.asObservable()
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { [weak self] error in
				guard let self = self else { return }
				if let common = error as? CommonErrors {
					guard common != .userCancelled else { return }
					let message = common.errorDescription ?? ""
					let header = common.hasCustomHeader ? common.errorHeader : "Error"
					self.bottomAlert(title: header ?? "", subtitle: nil, primaryButtonTitle: "OK", normalButtonTitle: "Cancel", description: message, primaryCompletionHandler:  {
						completionHandler?(error)
					})
				} else {
					self.bottomAlert(title: "Error", primaryButtonTitle: "Ok", description: error.localizedDescription, primaryCompletionHandler: {
						completionHandler?(error)
					})
				}
			}).disposed(by: disposeBag)
	}
}
