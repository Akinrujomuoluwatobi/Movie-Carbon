//
//  MovieDetailView.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import UIKit

class MovieDetailView: View {
	
	private let posterImage: UIImageView = {
		let imgView = UIImageView().layoutable()
		imgView.contentMode = .scaleAspectFill
		
		imgView.clipsToBounds = true
		return imgView
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
	
	private let movieActors: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.font = .systemFont(ofSize: 14, weight: .medium)
		
		return label
	}()
	
	private let movieDirectors: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.font = .systemFont(ofSize: 14, weight: .medium)
		
		return label
	}()
	
	private let awardWon: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.font = .systemFont(ofSize: 14, weight: .medium)
		
		return label
	}()
	
	private let moviePlot: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.numberOfLines = 5
		label.font = .systemFont(ofSize: 14, weight: .medium)
		
		return label
	}()
	
	private let movieLanguage: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 14, weight: .medium)
		
		return label
	}()
	
	private let movieRuntime: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 14, weight: .medium)
		
		return label
	}()
	
	private let movieTypeView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		view.isHidden = true
		view.applyCornerRadius(radius: 16, borderColor: .darkGray)
		return view
	}()
	
	override func setupViewHierarchy() {
		addSubviews([posterImage, movieTitle, movieTypeView, movieYear, movieActors, movieDirectors, awardWon, moviePlot, movieLanguage, movieRuntime])
		movieTypeView.addSubview(movieType)
	}
	
	override func setupConstraints() {
		posterImage.anchor(
			top: safeAreaLayoutGuide.topAnchor,
			leading: leadingAnchor,
			trailing: trailingAnchor,
			size: .init(width: 0, height: 250)
		)
		
		movieTypeView.anchor(
			top: posterImage.bottomAnchor,
			leading: leadingAnchor,
			padding: .init(top: 10, left: 16, bottom: 0, right: 10)
		)
		
		movieType.anchor(
			top: movieTypeView.topAnchor,
			leading: movieTypeView.leadingAnchor,
			bottom: movieTypeView.bottomAnchor,
			trailing: movieTypeView.trailingAnchor,
			padding: .init(top: 8, left: 16, bottom: 8, right: 16)
		)
		
		movieYear.anchor(
			bottom: movieType.bottomAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 0, left: 0, bottom: 0, right: 16)
		)
		
		movieDirectors.anchor(
			top: movieTypeView.bottomAnchor,
			leading: leadingAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 20, left: 16, bottom: 0, right: 16)
		)
		
		movieActors.anchor(
			top: movieDirectors.bottomAnchor,
			leading: leadingAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 20, left: 16, bottom: 0, right: 16)
		)
		
		awardWon.anchor(
			top: movieActors.bottomAnchor,
			leading: leadingAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 20, left: 16, bottom: 0, right: 16)
		)
		
		moviePlot.anchor(
			top: awardWon.bottomAnchor,
			leading: leadingAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 20, left: 16, bottom: 0, right: 16)
		)
		
		movieLanguage.anchor(
			top: moviePlot.bottomAnchor,
			leading: leadingAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 20, left: 16, bottom: 0, right: 16)
		)
		
		movieRuntime.anchor(
			top: movieLanguage.bottomAnchor,
			leading: leadingAnchor,
			trailing: trailingAnchor,
			padding: .init(top: 20, left: 16, bottom: 0, right: 16)
		)
	}
	
	func load(movieDetail: MovieDetailsModel) {
		
		movieYear.text = movieDetail.released ?? ""
		movieType.text = movieDetail.genre ?? ""
		movieTypeView.isHidden = false
		
		let directorAttributed = NSMutableAttributedString()
		directorAttributed.first("Directors: ", font: .systemFont(ofSize: 16, weight: .bold), textColor: .black)
		directorAttributed.next(movieDetail.director ?? "", font: .systemFont(ofSize: 16, weight: .medium), textColor: .darkGray)
		
		movieDirectors.attributedText = directorAttributed
		
		let actorAttributed = NSMutableAttributedString()
		actorAttributed.first("Actors: ", font: .systemFont(ofSize: 16, weight: .bold), textColor: .black)
		actorAttributed.next(movieDetail.actors ?? "", font: .systemFont(ofSize: 16, weight: .medium), textColor: .darkGray)
		
		movieActors.attributedText = actorAttributed
		
		let awardAttributed = NSMutableAttributedString()
		awardAttributed.first("Awards won: ", font: .systemFont(ofSize: 16, weight: .bold), textColor: .black)
		awardAttributed.next(movieDetail.awards ?? "", font: .systemFont(ofSize: 16, weight: .medium), textColor: .darkGray)
		
		awardWon.attributedText = awardAttributed
		
		let plotAttributed = NSMutableAttributedString()
		plotAttributed.first("Plot: ", font: .systemFont(ofSize: 16, weight: .bold), textColor: .black)
		plotAttributed.next(movieDetail.plot ?? "", font: .systemFont(ofSize: 16, weight: .medium), textColor: .darkGray)
		
		moviePlot.attributedText = plotAttributed
		
		let languageAttributed = NSMutableAttributedString()
		languageAttributed.first("Language: ", font: .systemFont(ofSize: 16, weight: .bold), textColor: .black)
		languageAttributed.next(movieDetail.language ?? "", font: .systemFont(ofSize: 16, weight: .medium), textColor: .darkGray)
		
		movieLanguage.attributedText = languageAttributed
		
		let runtimeAttributed = NSMutableAttributedString()
		runtimeAttributed.first("Runtime: ", font: .systemFont(ofSize: 16, weight: .bold), textColor: .black)
		runtimeAttributed.next(movieDetail.runtime ?? "", font: .systemFont(ofSize: 16, weight: .medium), textColor: .darkGray)
		
		movieRuntime.attributedText = runtimeAttributed
		
		guard let url = URL(string: movieDetail.poster ?? "") else { return }
		posterImage.kf.setImage(with: url)
	}
	
}
