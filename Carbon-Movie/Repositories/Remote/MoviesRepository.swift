//
//  MoviesRepository.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import RxSwift

protocol MoviesRepository {
	func getMovies(by search: String) -> Observable<MoviesSearchModel>
	func getMovieDetails(by id: String) -> Observable<MovieDetailsModel>
}

final class DefaultMoviesRepository: DefaultBaseRemoteRepository, MoviesRepository {
	func getMovies(by search: String) -> Observable<MoviesSearchModel> {
		let request = requestFactory.makeRequest(
			url: baseURLHolder.baseURL + "&s=\(search)",
			method: .GET,
			parameters: nil,
			headers: nil
		)
		
		return httpPerformer.performDataTask(with: request, responseType: MoviesSearchModel.self)
	}
	
	func getMovieDetails(by id: String) -> Observable<MovieDetailsModel> {
		let request = requestFactory.makeRequest(
			url: baseURLHolder.baseURL + "&i=\(id)",
			method: .GET,
			parameters: nil,
			headers: nil
		)
		
		return httpPerformer.performDataTask(with: request, responseType: MovieDetailsModel.self)
	}
	
}
