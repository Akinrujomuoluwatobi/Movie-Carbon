//
//  MovieCell.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import UIKit
import Kingfisher

final class MoviewCell: TableViewCell {
	
	private let posterImage: UIImageView = {
		let imgView = UIImageView().layoutable()
		imgView.contentMode = .scaleAspectFit
		imgView.clipsToBounds = true
		return imgView.withCornerRadius(10)
	}()
	
	private let movieTitle: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		
		return label
	}()
	
	private let movieType: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.font = .systemFont(ofSize: 14, weight: .medium)
		
		return label
	}()
	
	private let movieYear: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.font = .systemFont(ofSize: 12, weight: .medium)
		
		return label
	}()
	
	override func setupProperties() {
		selectionStyle = .none
	}
	
	override func setupViewHierarchy() {
		addSubviews([posterImage, movieTitle, movieType, movieYear])
	}
	
	override func setupConstraints() {
		posterImage.anchor(
			top: contentView.topAnchor,
			leading: contentView.leadingAnchor,
			bottom: contentView.bottomAnchor,
			padding: .init(top: 10, left: 10, bottom: 10, right: 10),
			size: .init(width: 80, height: 80)
		)
		
		movieTitle.anchor(
			top: posterImage.topAnchor,
			leading: posterImage.trailingAnchor,
			trailing: contentView.trailingAnchor,
			padding: .init(top: 0, left: 0, bottom: 0, right: 10)
		)
		
		movieType.anchor(
			top: movieTitle.bottomAnchor,
			leading: movieTitle.leadingAnchor,
			trailing: contentView.trailingAnchor,
			padding: .init(top: 8, left: 0, bottom: 0, right: 10)
		)
		
		movieYear.anchor(
			top: movieType.bottomAnchor,
			leading: movieTitle.leadingAnchor,
			trailing: contentView.trailingAnchor,
			padding: .init(top: 5, left: 0, bottom: 0, right: 0)
		)
	}
	
	func feed(with movie: Movie) {
		movieTitle.text = movie.title ?? ""
		movieYear.text = movie.year ?? ""
		movieType.text = movie.type ?? ""
		
		guard let url = URL(string: movie.poster ?? "") else { return }
		posterImage.kf.setImage(with: url)
	}
}
