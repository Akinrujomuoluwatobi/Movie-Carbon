//
//  RunObservable.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import Foundation
import RxSwift

typealias PresenterWithLoading = LoadablePresenter & ErrorThrowablePresenter & DisposableContainer

typealias ViewControllerWithLoading = ErrorThrowablePresenterContainer & LoadablePresenterContainer

protocol DisposableContainer: AnyObject {
	var disposable: Disposable? { get set }
}

extension LoadablePresenter where Self: ErrorThrowablePresenter & DisposableContainer {
	
	func runObservable(observable: Observable<Void>, shouldLoad: Bool = true) {
		disposable?.dispose()
		isLoading.accept(shouldLoad)
		disposable = observable
			.subscribe(onNext: { [weak self] _ in
				guard let self = self else { return }
				self.isLoading.accept(false)
			}, onError: { [weak self] error in
				guard let self = self else { return }
				self.isLoading.accept(false)
				self.error.onNext(error)
			})
	}
}
