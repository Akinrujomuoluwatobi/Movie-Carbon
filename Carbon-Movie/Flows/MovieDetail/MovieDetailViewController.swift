//
//  MovieDetailViewController.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import UIKit
import RxSwift

class MovieDetailViewController: ViewController<MovieDetailView>, MovieDetailRoutes, LoadablePresenterContainer, ErrorThrowablePresenterContainer {
	var loadablePresenter: LoadablePresenter {
		return presenter
	}
	
	var errorThrowablePresenter: ErrorThrowablePresenter {
		return presenter
	}
	
	var disposeBag = DisposeBag()
	
	var presenter: ListMoviesPresenter
		
	init(view: MovieDetailView, presenter: ListMoviesPresenter) {
		self.presenter = presenter
		super.init(view: view)
	}
	
	override func setupProperties() {
		presenter.fetchMovieDetails()
	}
	
	override func setupBehaviour() {
		//subscribeOnLoading()
		subscribeOnErrors()
		
		presenter.selectedMovie
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { movie in
				guard let movie = movie else { return }
				self.title = movie.title
			})
			.disposed(by: disposeBag)
		
		presenter.movieDetail
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { detail in
				guard let detail = detail else { return }
				self.customView.load(movieDetail: detail)
			}).disposed(by: disposeBag)
		
		presenter.isMovieExist
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { isSaved in
				self.customView.updateButton(isSaved: isSaved)
			}).disposed(by: disposeBag)
		
	}
	
	override func setupCallbacks() {
		customView.addFavourite.addTarget(self, action: #selector(addFavouriteTapped), for: .touchUpInside)
	}
	
	@objc func addFavouriteTapped() {
		if presenter.isFavourite {
			presenter.removeFavourite()
		} else {
			presenter.addFavourite()
		}
	}
}
