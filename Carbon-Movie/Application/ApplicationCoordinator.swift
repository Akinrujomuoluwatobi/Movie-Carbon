//
//  ApplicationCoordinator.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import UIKit
import Swinject
final class ApplicationCoordinator: BaseCoordinator {
	
	unowned let window: UIWindow
	
	private let navigationController = UINavigationController()
	
	init(window: UIWindow, container: Container) {
		self.window = window
		self.window.rootViewController = navigationController
		super.init(container: container)
	}
	
	override func start() {
		self.launchListMovies()
	}
	
	private func launchListMovies() {
		let listMoviesRoutes = container.resolve(ListMoviesRouteFactory.self)!
			.make(nil)
		
		listMoviesRoutes.showMovieDetails = { movie in
			self.launchMovieDetail(movie)
		}
		
		listMoviesRoutes.showFavourites = { [weak self] in
			self?.launchFavourites()
		}
		navigationController.setViewControllers([listMoviesRoutes.viewController], animated: true)
	}
	
	private func launchMovieDetail(_ movie: Movie) {
		let movieDetailRoutes = container.resolve(MovieDetailRouteFactory.self)!
			.make(movie)
		
		navigationController.pushViewController(movieDetailRoutes.viewController, animated: true)
	}
	
	private func launchFavourites() {
		let favouriteRoutes = container.resolve(FavouritesRoutesFactory.self)!
			.make(nil)
		
		favouriteRoutes.showMovieDetails = { movie in
			self.launchMovieDetail(movie)
		}
		
		navigationController.pushViewController(favouriteRoutes.viewController, animated: true)
	}
}
