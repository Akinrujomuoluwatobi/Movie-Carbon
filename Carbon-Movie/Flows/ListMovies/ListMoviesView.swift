//
//  ListMoviesView.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 04/11/2022.
//

import UIKit

class ListMoviesView: View {
	
	let searchTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Search by genre, directors"
		textField.font = .systemFont(ofSize: 14, weight: .medium)
		textField.textColor = .black
		textField.applyCornerRadius(radius: 10, borderColor: .darkGray)
		textField.backgroundColor = .clear
		
		return textField
	}()
	
	let searchButton: UIButton = {
		let button = UIButton(type: .custom)
		button.backgroundColor = .systemPurple
		button.setTitle("Search", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.applyCornerRadius(radius: 10, borderColor: .systemPurple)

		
		return button
	}()
	
	private let label: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.text = "Movies"
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
	
	override func setupViewHierarchy() {
		addSubviews([label, listTable, searchTextField, searchButton])
	}
	
	override func setupConstraints() {
		label.anchor(
			top: searchTextField.bottomAnchor,
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
		
		searchTextField.anchor(
			top: safeAreaLayoutGuide.topAnchor,
			leading: leadingAnchor,
			trailing: searchButton.leadingAnchor,
			padding: .init(top: 0, left: 16, bottom: 16, right: 16),
			size: .init(width: 0, height: 48)
		)
		
		searchButton.anchor(
			top: searchTextField.topAnchor,
			bottom: searchTextField.bottomAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 0, left: 0, bottom: 0, right: 16),
			size: .init(width: 80, height: 0)
		)
	}
	
}
