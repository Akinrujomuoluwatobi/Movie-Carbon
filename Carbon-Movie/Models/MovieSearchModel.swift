//
//  MovieSearchModel.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import Foundation

// MARK: - MoviesSearchModel
struct MoviesSearchModel: Codable {
	var search: [Movie]?
	var totalResults, response: String?
	
	enum CodingKeys: String, CodingKey {
		case search = "Search"
		case totalResults
		case response = "Response"
	}
}

// MARK: - Search
struct Movie: Codable {
	var title, year, imdbID: String?
	var type: String?
	var poster: String?
	
	enum CodingKeys: String, CodingKey {
		case title = "Title"
		case year = "Year"
		case imdbID
		case type = "Type"
		case poster = "Poster"
	}
}
