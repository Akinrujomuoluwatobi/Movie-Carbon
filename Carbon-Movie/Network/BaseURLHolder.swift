//
//  BaseURLConfig.swift
//

protocol BaseURLHolder {
	var baseURL: String { get }
}

final class DefaultBaseURLHolder: BaseURLHolder {
	
	var baseURL: String {
		return "https://www.omdbapi.com/?apikey=670d5f9c"
		
	}
}
