//
//  MovieDetailRouteFactory.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import Foundation

protocol MovieDetailRouteFactory {
	func make(_ movie: Movie?) -> MovieDetailRoutes
}

class DefaultMovieDetailRouteFactory: BaseFactory, MovieDetailRouteFactory {
	func make(_ movie: Movie? = nil) -> MovieDetailRoutes {
		return MovieDetailViewController(view: MovieDetailView(), presenter: container.resolve(ListMoviesPresenter.self, argument: movie)!)
	}
}
