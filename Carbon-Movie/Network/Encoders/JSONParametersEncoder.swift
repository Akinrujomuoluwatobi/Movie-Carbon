//
//  JSONParametersEncoder.swift
//  GoMoney
//

import UIKit

struct JSONParametersEncoder: ParametersEncoder {
	
	func encode(parameters: [String: Any], in request: URLRequest) throws -> URLRequest {
		var request = request
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		let value = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
		request.httpBody = value
		return request
	}
	
	func encode(parameters: [String: String]?, datas: [String: Data], in request: URLRequest, isAppruve: Bool) throws -> URLRequest {
		var request = request
		let boundary = createBoundary()
		
		request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
		let dataBody = createDataBody(withParameters: parameters, datas: datas, boundary: boundary)
		request.httpBody = dataBody
		return request
	}
	
	private func createDataBody(withParameters params: [String: String]?, datas: [String: Data], boundary: String) -> Data {
		
		let lineBreak = "\r\n"
		var body = Data()
		
		if let parameters = params {
			for (key, value) in parameters {
				body.append("--\(boundary + lineBreak)")
				body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
				body.append("\(value + lineBreak)")
			}
		}
		
		for data in datas {
			let fileName = "\(data.key)-\(Date().description).jpeg"
			body.append("--\(boundary + lineBreak)")
			body.append("Content-Disposition: form-data; name=\"\(data.key)\"; filename=\"\(fileName)\"\(lineBreak)")
			body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
			body.append(data.value)
			body.append(lineBreak)
		}
		
		body.append("--\(boundary)--\(lineBreak)")
		return body
	}
	
	private func createBoundary() -> String {
		return "Boundary-\(UUID().uuidString)"
	}
}
