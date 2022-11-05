//
//  HTTPRequestFactory.swift
//

import RxSwift

protocol RequestFactory {
    func makeRequest(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?) -> URLRequest
        func makeRequest(url: String, method: HTTPMethod, parameters: [String: String]?, datas: [String: Data], headers: [String: String]?, isAppruve: Bool) -> URLRequest
}

extension RequestFactory {
    func makeRequestmakeRequest(url: String, method: HTTPMethod, parameters: [String: String]?, datas: [String: Data], headers: [String: String]?, isAppruve: Bool = false) -> URLRequest {
        return makeRequest(url: url, method: method, parameters: parameters, datas: datas, headers: headers, isAppruve: isAppruve)
    }
}

final class DefaultRequestFactory: RequestFactory {

    func makeRequest(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?) -> URLRequest {
        let encoding: ParametersEncoder = [.GET, .DELETE].contains(method) ? URLParameretersEncoder() : JSONParametersEncoder()

        guard let url = URL(string: url) else {
            fatalError("Wrong URL")
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 46.0)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue

        if let parameters = parameters {
            guard let encoded = try? encoding.encode(parameters: parameters, in: urlRequest) else {
                fatalError()
            }
            urlRequest = encoded
        }
//
//        urlRequest.setValue(Bundle.main.buildNumber, forHTTPHeaderField: "x-build-number")
//        urlRequest.setValue("GoMoney/\(Bundle.main.buildNumber) CFNetwork/902.2 Darwin/17.7.0", forHTTPHeaderField: "user-agent")
//
        if let headers = headers {
            headers.forEach {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        
        return urlRequest
    }
    
    func makeRequest(url: String, method: HTTPMethod, parameters: [String: String]?, datas: [String: Data], headers: [String: String]?, isAppruve: Bool) -> URLRequest {
        let encoding: ParametersEncoder = JSONParametersEncoder()
        
        guard let url = URL(string: url) else {
            fatalError("Wrong URL")
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 46.0)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue
        
        guard let encoded = try? encoding.encode(parameters: parameters, datas: datas, in: urlRequest, isAppruve: isAppruve) else {
                fatalError()
            }
        urlRequest = encoded
//
//
//        urlRequest.setValue(Bundle.main.buildNumber, forHTTPHeaderField: "x-build-number")
//        urlRequest.setValue("GoMoney/\(Bundle.main.buildNumber) CFNetwork/902.2 Darwin/17.7.0", forHTTPHeaderField: "user-agent")
//
        if let headers = headers {
            headers.forEach {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        
        return urlRequest
    }
}
