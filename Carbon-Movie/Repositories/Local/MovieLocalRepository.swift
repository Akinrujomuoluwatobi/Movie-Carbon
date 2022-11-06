//
//  MovieLocalRepository.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 06/11/2022.
//

import UIKit
import RxSwift
import RealmSwift

protocol MovieLocalRepository {
	func save(value: Movie)
	func update(value: Movie)
	func remove(id: String)
	func saveMany(value: [Movie])
	func getAllObservable() -> Observable<[Movie]>
	func getAll() -> [Movie]
	func getMovie(id: String) -> Movie?
	func reloadAll(value: [Movie])
	var isEmpty: Bool { get }
}

class DefaultMovieLocalRepository: BaseRealmRepository<Movie>, MovieLocalRepository {
	func getMovie(id: String) -> Movie? {
		return getById(id: id)
	}
	
	func reloadAll(value: [Movie]) {
		removeAll()
		saveMany(value: value)
	}
	
	func removeBill(_ id: String) {
		remove(id: id)
	}
	
	var isEmpty: Bool {
		return getAll().isEmpty
	}
	
	func getAllObservable() -> Observable<[Movie]> {
		
		return getRawFromRepository()
	}
	
	func getRawFromRepository() -> Observable<[Movie]> {
		return Observable.create { [weak self] in
			if let all = self?.getAll() {
				$0.onNext(all)
			} else {
				$0.onError(CommonErrors.arc)
			}
			$0.onCompleted()
			return Disposables.create()
		}
	}
}
