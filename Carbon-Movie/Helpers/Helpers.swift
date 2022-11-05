//
//  Helpers.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import Foundation

func abstractMethod() -> Never {
	fatalError("this method should be overriden")
}

enum CommonErrors: Error, Equatable {
	case arc
	case undefined
	case userCancelled
	case messaged(text: String, header: String? = nil)
}

extension CommonErrors: LocalizedError {
	
	public var errorDescription: String? {
		switch self {
			case .messaged(let text, _):
				return text
			default:
				return "There was a problem with finishing your request. Please try again."
		}
	}
	
	public var hasCustomHeader: Bool {
		switch self {
			case .messaged(_, let header):
				return header != nil
			default:
				return false
		}
	}
	
	public var errorHeader: String? {
		switch self {
			case .messaged(_, let header):
				return header
			default:
				return "Error"
		}
	}
}
