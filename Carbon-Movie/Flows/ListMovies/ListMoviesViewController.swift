//
//  ListMoviesViewController.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import UIKit
import RxSwift

class ListMoviesViewController: ViewController<ListMoviesView>, ListMoviesRoutes, LoadablePresenterContainer, ErrorThrowablePresenterContainer {
	var loadablePresenter: LoadablePresenter {
		return presenter
	}
	
	var errorThrowablePresenter: ErrorThrowablePresenter {
		return presenter
	}
	
	var disposeBag = DisposeBag()
	
	var presenter: ListMoviesPresenter
	
	var showMovieDetails: ((Movie) -> Void)?
	
	init(view: ListMoviesView, presenter: ListMoviesPresenter) {
		self.presenter = presenter
		super.init(view: view)
	}
	
	override func setupProperties() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourites", style: .plain, target: self, action: #selector(launchFavourites))
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
	
	override func setupCallbacks() {
		customView.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
	}
	
	@objc func launchFavourites() {
		
	}
	
	@objc func searchButtonPressed() {
		guard let searchTerm = customView.searchTextField.text else { return }
		presenter.getMovies(search: searchTerm)
	}
}

extension ListMoviesViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return presenter.movies.value.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeue(dequeueableCell: MoviewCell.self, forIndexPath: indexPath)
		cell.feed(with: presenter.movies.value[indexPath.row])
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.showMovieDetails?(presenter.movies.value[indexPath.row])
	}
	
}
