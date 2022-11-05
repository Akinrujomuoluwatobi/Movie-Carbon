//
//  ObservableExtension.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import RxSwift

extension Observable {
	func toVoid() -> Observable<Void> {
		return map { _ in }
	}
}

extension ObservableType {
	
	/// Perform an action on an Observable element without manipulating the element
	/// - Parameter selector: Closure to execute the action
	/// - Returns: Orignal observable
	func execute(_ selector: @escaping (Element) -> Void) -> Observable<Element> {
		return flatMap { result in
			return Observable
				.just(selector(result))
				.map { _ in result }.take(1)
		}
	}
	
	func unwrap<T>() -> Observable<T> where Element == T? {
		return compactMap { $0 }
	}
}
