//
//  ListMoviesPresenter.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import UIKit
import RxSwift
import RxRelay

protocol ListMoviesPresenter: LoadablePresenter, ErrorThrowablePresenter {
	var movies: BehaviorRelay<[Movie]> { get }
	var selectedMovie: BehaviorRelay<Movie?> { get }
	var movieDetail: BehaviorRelay<MovieDetailsModel?> { get }
	func fetchMovieDetails()
	func getMovies(search: String)
}

final class DefaultListMoviesPresenter: ListMoviesPresenter, DisposableContainer {
	var disposable: Disposable?
	
	var movies = BehaviorRelay<[Movie]>(value: [])
	
	var isLoading = BehaviorRelay(value: false)
	
	var error = PublishSubject<Error>()
	
	var disposeBag = DisposeBag()
	
	var remoteRepository: MoviesRepository
	
	var selectedMovie = BehaviorRelay<Movie?>(value: nil)
	
	var movieDetail = BehaviorRelay<MovieDetailsModel?>(value: nil)
	
	init(remoteRepository: MoviesRepository, movie: Movie? = nil) {
		self.selectedMovie.accept(movie)
		self.remoteRepository = remoteRepository
	}
	
	func getMovies(search: String) {
		let observable = remoteRepository.getMovies(by: search)
			.observe(on: MainScheduler.instance)
			.map ({[weak self] data in
				self?.movies.accept(data.search ?? [])
			}).toVoid()
		
		runObservable(observable: observable)
	}
	
	func fetchMovieDetails() {
		guard let movieID = selectedMovie.value?.imdbID else { return }
		let observable = remoteRepository.getMovieDetails(by: movieID)
			.observe(on: MainScheduler.instance)
			.map ({[weak self] data in
				self?.movieDetail.accept(data)
			}).toVoid()
		
		runObservable(observable: observable)
	}
	
}
