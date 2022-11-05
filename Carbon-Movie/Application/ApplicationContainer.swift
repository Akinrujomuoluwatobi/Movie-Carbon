//
//  ApplicationContainer.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import Swinject

enum ApplicationContainer {
	static func build(in container: Container) {
		
		container.register(RequestFactory.self) { resolver in
			return DefaultRequestFactory()
		}
		
		container.register(URLSession.self) { resolver in
			return URLSession.shared
		}
		
		container.register(BaseURLHolder.self) { resolver in
			return DefaultBaseURLHolder()
		}
		
		container.register(HTTPRequestPerformer.self) { resolver in
			return DefaultHTTPRequestPerformer(session: resolver.resolve(URLSession.self)!)
		}
		
		container.register(ListMoviesRouteFactory.self) {
			return DefaultListMoviesRouteFactory(container: $0 as! Container)
		}
		
		container.register(MoviesRepository.self) { resolver in
			return DefaultMoviesRepository(
				requestFactory: resolver.resolve(RequestFactory.self)!,
				httpPerformer: resolver.resolve(HTTPRequestPerformer.self)!,
				baseURLHolder: resolver.resolve(BaseURLHolder.self)!
			)
		}
		
		container.register(ListMoviesPresenter.self) { (resolver, movie: Movie?) in
			return DefaultListMoviesPresenter(remoteRepository: resolver.resolve(MoviesRepository.self)!, movie: movie)
		}
		
		container.register(MovieDetailRouteFactory.self) {
			return DefaultMovieDetailRouteFactory(container: $0 as! Container)

		}
	}
}
