//
//  FavouritesRoutes.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 06/11/2022.
//

import Foundation

protocol FavouritesRoutes: ViewControllerRoutes {
	var showMovieDetails: ((Movie) -> Void)? { get set }
}
