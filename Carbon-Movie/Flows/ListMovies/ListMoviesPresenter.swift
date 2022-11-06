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
	var favouriteMovies: BehaviorRelay<[Movie]> { get }
	var movieDetail: BehaviorRelay<MovieDetailsModel?> { get }
	var isMovieExist: BehaviorRelay<Bool> { get }
	var isFavourite: Bool { get }
	func fetchMovieDetails()
	func fetchFavourite()
	func getMovies(search: String)
	func addFavourite()
	func removeFavourite()
}

final class DefaultListMoviesPresenter: ListMoviesPresenter, DisposableContainer {
	var disposable: Disposable?
	
	var movies = BehaviorRelay<[Movie]>(value: [])
	
	var favouriteMovies = BehaviorRelay<[Movie]>(value: [])
	
	var isLoading = BehaviorRelay(value: false)
	
	var error = PublishSubject<Error>()
	
	var disposeBag = DisposeBag()
	
	var remoteRepository: MoviesRepository
	
	var movieLocalRepository: MovieLocalRepository
	
	var selectedMovie = BehaviorRelay<Movie?>(value: nil)
	
	var movieDetail = BehaviorRelay<MovieDetailsModel?>(value: nil)
	
	var isMovieExist = BehaviorRelay<Bool>(value: false)
	
	var isFavourite: Bool {
		guard let movieID = selectedMovie.value?.id else { return false }
		let movie = movieLocalRepository.getMovie(id: movieID)
		return (movie != nil)
	}
	
	init(remoteRepository: MoviesRepository, movie: Movie? = nil, movieLocalRepository: MovieLocalRepository) {
		self.selectedMovie.accept(movie)
		self.remoteRepository = remoteRepository
		self.movieLocalRepository = movieLocalRepository
		checkSavedMovie()
	}
	
	func checkSavedMovie() {
		guard let movieID = selectedMovie.value?.id else { return }
		let movie = movieLocalRepository.getMovie(id: movieID)
		isMovieExist.accept((movie != nil) ? true : false )
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
		guard let movieID = selectedMovie.value?.id else { return }
		let observable = remoteRepository.getMovieDetails(by: movieID)
			.observe(on: MainScheduler.instance)
			.map ({[weak self] data in
				self?.movieDetail.accept(data)
			}).toVoid()
		
		runObservable(observable: observable)
	}
	
	func addFavourite() {
		guard let selectedMovie = selectedMovie.value else { return }
		movieLocalRepository.save(value: selectedMovie)
		checkSavedMovie()
	}
	
	func removeFavourite() {
		guard let selectedMovie = selectedMovie.value?.id else { return }
		movieLocalRepository.remove(id: selectedMovie)
		checkSavedMovie()
	}
	
	func fetchFavourite() {
		let favMovies = movieLocalRepository.getAll()
		favouriteMovies.accept(favMovies)
	}
}
