//
//  RealmConfigurationFactory.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import Foundation
import RealmSwift

protocol RealmConfigurationFactory {
	func make() -> Realm.Configuration
}

final class DefaultRealmConfigurationFactory: RealmConfigurationFactory {
	
	func make() -> Realm.Configuration {
		let config = Realm.Configuration(
			fileURL: Realm.Configuration.defaultConfiguration.fileURL,
			schemaVersion: 1,
			migrationBlock: { _, _ in },
			deleteRealmIfMigrationNeeded: false,
			objectTypes: [
				RMMovie.self
			]
		)
		
		return config
	}
}
