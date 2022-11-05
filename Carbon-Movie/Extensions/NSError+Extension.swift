//
//  NSError+Extension.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import Foundation

extension NSError {
	
	convenience init(_ localizedDescriprion: String) {
		self.init(domain: "com.sterling", code: 0, userInfo: [NSLocalizedDescriptionKey: localizedDescriprion])
	}
	
	var serverError: ServerError? {
		print(userInfo)
		guard
			domain == HTTPErrorDomains.server,
			let errorBody = userInfo[RequestPerformerKeys.errorBodyKey] as? String
		else {
			return nil
		}
		return ServerError(statusCode: code, body: errorBody)
	}
	
	static func decodingError(with statusCode: Int) -> NSError {
		return NSError(
			domain: HTTPErrorDomains.decoding,
			code: statusCode,
			userInfo: [RequestPerformerKeys.errorBodyKey: "Decoding Error"]
		)
	}
	
	static let undefined = NSError(domain: HTTPErrorDomains.undefined, code: 0)
}
