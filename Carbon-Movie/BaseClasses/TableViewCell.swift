//
//  TableViewCell.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .white
		setupViewHierarchy()
		setupConstraints()
		setupProperties()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupViewHierarchy() {
		abstractMethod()
	}
	
	func setupConstraints() {
		abstractMethod()
	}
	
	func setupProperties() {
		contentView.isUserInteractionEnabled = true
		isUserInteractionEnabled = true
	}
}
