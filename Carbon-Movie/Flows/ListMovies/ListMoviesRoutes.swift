//
//  ListMoviesRoutes.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import Foundation

protocol ListMoviesRoutes: ViewControllerRoutes {
	var showMovieDetails: ((Movie) -> Void)? { get set }
	var showFavourites: (() -> Void)? { get set }
}
