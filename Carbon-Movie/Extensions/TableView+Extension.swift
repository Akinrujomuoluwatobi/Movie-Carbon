//
//  TableView+Extension.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import UIKit

extension UITableView {
	
	/// Registers a new cell type for a tableView with it's class name as reuse identifier.
	func register<Cell>(dequeueableCell: Cell.Type) where Cell: UITableViewCell {
		register(Cell.self, forCellReuseIdentifier: Cell.className)
	}
	
	/// Returns a dequeued cell with specific cell type.
	func dequeue<Cell>(dequeueableCell: Cell.Type, forIndexPath indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
		guard let cell = dequeueReusableCell(withIdentifier: dequeueableCell.className, for: indexPath) as? Cell else {
			fatalError("Could not dequeue cell of type \(Cell.self) with reuseIdentifier \(Cell.className)")
		}
		return cell
	}
	
	func deselectAll(animated: Bool) {
		guard let selectionIndexPath = indexPathForSelectedRow else { return }
		deselectRow(at: selectionIndexPath, animated: animated)
	}
	
	/// Registers a new header cell type for a tableView with it's class name as reuse identifier.
	func registerHeader<Cell>(dequeueableCell: Cell.Type) where Cell: UITableViewHeaderFooterView {
		register(Cell.self, forHeaderFooterViewReuseIdentifier: Cell.className)
	}
	
	/// Returns a dequeued header cell with specific cell type.
	func dequeueHeader<Cell>(dequeueableCell: Cell.Type) -> Cell where Cell: UITableViewHeaderFooterView {
		guard let cell = dequeueReusableHeaderFooterView(withIdentifier: dequeueableCell.className) as? Cell else {            fatalError("Could not dequeue cell header of type \(Cell.self) with reuseIdentifier \(Cell.className)")
		}
		return cell
	}
}
