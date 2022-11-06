//
//  FavouriteView.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 06/11/2022.
//

import UIKit

class FavouritesView: View {
	
	private let label: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.text = "Favourite Movies"
		label.font = .systemFont(ofSize: 24, weight: .bold)
		label.textColor = .black
		
		return label
	}()
	
	let listTable: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = .white
		tableView.rowHeight = 100
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()
	
	// MARK: - Override functions
	
	override func setupViewHierarchy() {
		addSubviews([label, listTable])
	}
	
	override func setupConstraints() {
		label.anchor(
			top: safeAreaLayoutGuide.topAnchor,
			leading: leadingAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 16, left: 16, bottom: 16, right: 16)
		)
		
		listTable.anchor(
			top: label.bottomAnchor,
			leading: leadingAnchor,
			bottom: bottomAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 0, left: 16, bottom: 16, right: 16)
		)
	
	}
	
}
