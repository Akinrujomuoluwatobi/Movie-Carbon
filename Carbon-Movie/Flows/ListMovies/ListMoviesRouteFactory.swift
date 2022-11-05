//
//  ListMoviesRouteFactory.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import Foundation

protocol ListMoviesRouteFactory {
	func make(_ movie: Movie?) -> ListMoviesRoutes
}

class DefaultListMoviesRouteFactory: BaseFactory, ListMoviesRouteFactory {
	func make(_ movie: Movie? = nil) -> ListMoviesRoutes {
		return ListMoviesViewController(view: ListMoviesView(), presenter: container.resolve(ListMoviesPresenter.self, argument: movie)!)
	}
}
