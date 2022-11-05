//
//  URLPArametersEncoder.swift
//

import UIKit

struct URLParameretersEncoder: ParametersEncoder {

    func encode(parameters: [String: Any], in request: URLRequest) throws -> URLRequest {
        var request = request
        var query = "?"

        parameters.forEach {
            query.append("\($0.key)=\($0.value)&")
        }

        // Removes last component of the query.
        query.removeLast()

        guard
            let urlString = request.url?.absoluteString,
            let encoded = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: urlString + encoded)
        else {
            throw NSError("Error")
        }
        request.url = url
        return request
    }
    
    func encode(parameters: [String: String]?, datas: [String: Data], in request: URLRequest, isAppruve: Bool) throws -> URLRequest {
        var request = request
        var query = "?"

        parameters?.forEach {
            query.append("\($0.key)=\($0.value)&")
        }

        /// Removes last component of the query.
        query.removeLast()

        guard
            let urlString = request.url?.absoluteString,
            let encoded = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: urlString + encoded)
        else {
            throw NSError("Error")
        }
        request.url = url
        return request
    }
}
