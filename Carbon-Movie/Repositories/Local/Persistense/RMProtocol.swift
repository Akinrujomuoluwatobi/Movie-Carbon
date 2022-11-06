//
//  RealmProtocol.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import Foundation
import RealmSwift

protocol DomainConvertibleType {
	
	associatedtype DomainType
	
	func asDomain() -> DomainType
}

protocol RealmRepresentable {
	
	associatedtype RealmType: DomainConvertibleType & Object
	
	var id: String { get }
	
	func asRealm() -> RealmType
}
