//
//  FavouritesRoutesFactory.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 06/11/2022.
//

import Foundation

protocol FavouritesRoutesFactory {
	func make(_ movie: Movie?) -> FavouritesRoutes
}

class DefaultFavouritesRoutesFactory: BaseFactory, FavouritesRoutesFactory {
	func make(_ movie: Movie? = nil) -> FavouritesRoutes {
		return FavouritesViewController(view: FavouritesView(), presenter: container.resolve(ListMoviesPresenter.self, argument: movie)!)
	}
}
