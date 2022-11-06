//
//  BaseRealmRepository.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import RealmSwift

class BaseRealmRepository<T: RealmRepresentable>: BaseAbstractRepository where T.RealmType.DomainType == T {
	
	lazy var realm: Realm = {
		return try! Realm(configuration: configuration)
	}()
	
	private let configuration: Realm.Configuration
	
	let scheduler: ThreadScheduler
	
	init(configuration: Realm.Configuration, scheduler: ThreadScheduler) {
		self.configuration = configuration
		self.scheduler = scheduler
		print("Realm path " + (Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? ""))
	}
	
	func save(value: T) {
		scheduler.performSync {
			try! self.realm.write {
				self.realm.add(value.asRealm(), update: .all)
			}
		}
	}
	
	func update(value: T) {
		scheduler.performSync {
			try! self.realm.write {
				self.realm.add(value.asRealm(), update: .modified)
			}
		}
	}
	
	func saveMany(value: [T]) {
		scheduler.performSync {
			try! self.realm.write {
				print(value.map({ $0.asRealm() }))
				self.realm.add(value.map({ $0.asRealm() }), update: .all)
			}
		}
	}
	
	func remove(value: T) {
		scheduler.performSync {
			try! self.realm.write {
				self.realm.delete(value.asRealm())
			}
		}
	}
	
	func remove(id: String) {
		scheduler.performSync {
			try! self.realm.write {
				if let value = self.realm.object(ofType: T.RealmType.self, forPrimaryKey: id) {
					self.realm.delete(value)
				}
			}
		}
	}
	
	func remove(predicate: NSPredicate) {
		scheduler.performSync {
			try! self.realm.write {
				let filtered = self.realm.objects(T.RealmType.self).filter(predicate)
				guard !filtered.isEmpty else { return }
				self.realm.delete(filtered)
			}
		}
	}
	
	func get(predicate: NSPredicate) -> T? {
		return scheduler.performSync {
			//swiftlint:disable first_where
			return self.realm.objects(T.RealmType.self).filter(predicate).first?.asDomain()
		}
	}
	
	func getById(id: String) -> T? {
		return scheduler.performSync {
			return self.realm.object(ofType: T.RealmType.self, forPrimaryKey: id)?.asDomain()
		}
	}
	
	func getAll() -> [T] {
		return scheduler.performSync {
			let objects = self.realm.objects(T.RealmType.self)
			return objects.map { $0.asDomain() }
		}
	}
	
	func getAllByPredicate(predicate: NSPredicate) -> [T] {
		return scheduler.performSync {
			let objects = self.realm.objects(T.RealmType.self).filter(predicate)
			return objects.map { $0.asDomain() }
		}
	}
	
	func removeAll() {
		scheduler.performSync {
			let objects = self.realm.objects(T.RealmType.self)
			try! self.realm.write {
				self.realm.delete(objects)
			}
		}
	}
}
