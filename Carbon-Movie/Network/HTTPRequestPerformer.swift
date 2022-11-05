//
//  HTTPRequestPerformer.swift
//

import RxSwift

protocol HTTPRequestPerformer {
    func performDataTask<T: Decodable>(with request: URLRequest, responseType: T.Type) -> Observable<T>
    func performDataTask<T: Decodable>(with request: URLRequest, responseType: T.Type, customDecoder: JSONDecoder) -> Observable<T>
}

final class DefaultHTTPRequestPerformer: HTTPRequestPerformer {

    let session: URLSession

    private let disposeBag = DisposeBag()


    init(session: URLSession) {
        self.session = session
    }

    func performDataTask<T: Decodable>(with request: URLRequest, responseType: T.Type) -> Observable<T> {
        return performDataTask(with: request, responseType: responseType, customDecoder: JSONDecoder())
    }

    func performDataTask<T>(with request: URLRequest, responseType: T.Type, customDecoder: JSONDecoder) -> Observable<T> where T: Decodable {

//        if let requestData = request.httpBody, let body = String(bytes: requestData, encoding: .utf8) {
//            LOGGER.d(body)
//        }
        return Observable.create({ [weak self] observer in
            guard let self = self else {
                observer.onCompleted()
                return Disposables.create()
            }

            let task = self.session.dataTask(with: request, completionHandler: { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    if let response = response as? HTTPURLResponse {
                        guard let data = data else {
                            observer.onCompleted()
                            return
                        }
                        switch response.statusCode {
                        case 200 ..< 300:
                            let decoder = customDecoder
                            do {
                                let parsedResponse = try decoder.decode(responseType, from: data)
                                observer.onNext(parsedResponse)
                            } catch let decodingError {
                                debugPrint(decodingError)
                                observer.onError(NSError.decodingError(with: response.statusCode))
                            }
                            observer.onCompleted()
                        default:
														observer.onError(NSError.decodingError(with: response.statusCode))

//                            guard let parsedErrorResponse = try? customDecoder.decode( BackendErrorResponse.self, from: data) else {
//                                observer.onError(NSError.decodingError(with: response.statusCode))
//                                return
//                            }

//                            if BackendErrorConstants.invalidToken == parsedErrorResponse {
//                                self.rxNotificationCenter.post(.invalidToken)
//                            }
//
//                            if BackendErrorConstants.expiredSessionToken == parsedErrorResponse {
//                                self.rxNotificationCenter.post(.invalidToken)
//                            }

//                            let error = BackendError(errorResponse: parsedErrorResponse)
//                            observer.onError(error)
                        }
                    } else {
                        observer.onError(NSError.undefined)
                    }
                }
            })
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        })
    }
}

extension Data {
    var prettyPrintedJSONString: CustomStringConvertible {
        let dictionary = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any] ?? [:]
        return dictionary ?? [:]
    }
}
