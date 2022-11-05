//
//  BaseFactory.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import UIKit
import Swinject

class BaseFactory {
	
	unowned let container: Container
	
	init(container: Container) {
		self.container = container
	}
}
