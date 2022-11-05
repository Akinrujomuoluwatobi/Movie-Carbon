//
//  ParametersEncoder.swift
//  GoMoney
//

import UIKit

protocol ParametersEncoder {
    func encode(parameters: [String: Any], in request: URLRequest) throws -> URLRequest
    func encode(parameters: [String: String]?, datas: [String: Data], in request: URLRequest, isAppruve: Bool) throws -> URLRequest
}
