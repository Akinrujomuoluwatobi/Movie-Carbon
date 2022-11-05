//
//  Data+Extension.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import Foundation

extension NSMutableData {
	
	func appendString(_ string: String) {
		append(string.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
	}
}

extension Data {
	mutating func append(_ string: String) {
		if let data = string.data(using: .utf8) {
			append(data)
		}
	}
}
