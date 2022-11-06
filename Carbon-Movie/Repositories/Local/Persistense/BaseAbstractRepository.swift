//
//  BaseAbstractRepository.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import Foundation

protocol BaseAbstractRepository {
	associatedtype T
	func save(value: T)
	func update(value: T)
	func remove(value: T)
	func getById(id: String) -> T?
	func remove(id: String)
	func get(predicate: NSPredicate) -> T?
	func getAllByPredicate(predicate: NSPredicate) -> [T]
	func getAll() -> [T]
}
