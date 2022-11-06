//
//  MovieSearchModel.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import RealmSwift

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
	var title, year: String
	let id: String
	var type: String?
	var poster: String?
	
	enum CodingKeys: String, CodingKey {
		case title = "Title"
		case year = "Year"
		case id = "imdbID"
		case type = "Type"
		case poster = "Poster"
	}
}

extension Movie: RealmRepresentable {
	
	func asRealm() -> RMMovie {
		let movie = RMMovie()
		movie.id = id ?? ""
		movie.title = title ?? ""
		movie.year = year ?? ""
		movie.type = type ?? ""
		movie.poster = poster ?? ""
		
		return movie
	}
}

final class RMMovie: Object {
	
	@objc dynamic var id: String = ""
	@objc dynamic var title: String = ""
	@objc dynamic var year: String = ""
	@objc dynamic var poster: String = ""
	@objc dynamic var type: String = ""
	
	override class func primaryKey() -> String {
		return "id"
	}
}

extension RMMovie: DomainConvertibleType {
	func asDomain() -> Movie {
		let movie = Movie(
			title: title,
			year: year,
			id: id,
			type: type,
			poster: poster
		)
		return movie
	}
}

