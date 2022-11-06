//
//  FavouritesViewController.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 06/11/2022.
//

import UIKit
import RxSwift

class FavouritesViewController: ViewController<FavouritesView>, FavouritesRoutes, LoadablePresenterContainer, ErrorThrowablePresenterContainer {
	var loadablePresenter: LoadablePresenter {
		return presenter
	}
	
	var errorThrowablePresenter: ErrorThrowablePresenter {
		return presenter
	}
	
	var disposeBag = DisposeBag()
	
	var presenter: ListMoviesPresenter
	
	var showMovieDetails: ((Movie) -> Void)?
	
	init(view: FavouritesView, presenter: ListMoviesPresenter) {
		self.presenter = presenter
		super.init(view: view)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		presenter.fetchFavourite()
	}
	
	override func setupBehaviour() {
		//subscribeOnLoading()
		subscribeOnErrors()
		customView.listTable.delegate = self
		customView.listTable.dataSource = self
		customView.listTable.register(dequeueableCell: MoviewCell.self)
		presenter.movies
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { movies in
				self.customView.listTable.reloadData()
			}).disposed(by: disposeBag)
	}

}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return presenter.favouriteMovies.value.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeue(dequeueableCell: MoviewCell.self, forIndexPath: indexPath)
		cell.feed(with: presenter.favouriteMovies.value[indexPath.row])
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.showMovieDetails?(presenter.favouriteMovies.value[indexPath.row])
	}
	
}
