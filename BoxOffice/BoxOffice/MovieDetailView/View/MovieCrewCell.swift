//
//  MovieCrewCell.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/16.
//

import Foundation
import UIKit
import SnapKit

class MovieCrewCell: UITableViewCell {

  // MARK: UI

  private let title: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.text = "감독/출연"
    return label
  }()
  private let directorTitle: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    label.text = "감독"
    return label
  }()
  private let director: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let actorsTitle: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    label.text = "출연"
    return label
  }()
  private let actors: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    label.numberOfLines = 2
    return label
  }()


  // MARK: Initializing

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Set

  func set(movie: MovieInfoModel) {
    self.actors.text = movie.actor
    self.director.text = movie.director
    self.actors.sizeToFit()
    self.director.sizeToFit()
  }


  // MARK: Layout

  func layout() {
    self.contentView.addSubview(self.actorsTitle)
    self.contentView.addSubview(self.actors)
    self.contentView.addSubview(self.directorTitle)
    self.contentView.addSubview(self.director)
    self.contentView.addSubview(self.title)

    self.title.snp.makeConstraints{
      $0.top.equalToSuperview().inset(5)
      $0.leading.equalToSuperview().inset(5)
    }
    self.directorTitle.snp.makeConstraints{
      $0.top.equalTo(self.title.snp.bottom).offset(10)
      $0.leading.equalToSuperview().inset(10)
    }
    self.director.snp.makeConstraints{
      $0.top.equalTo(self.directorTitle)
      $0.leading.equalTo(self.directorTitle.snp.trailing).offset(10)
    }
    self.actorsTitle.snp.makeConstraints{
      $0.top.equalTo(self.directorTitle.snp.bottom).offset(10)
      $0.leading.equalTo(self.directorTitle)
    }
    self.actors.snp.makeConstraints{
      $0.top.equalTo(self.actorsTitle)
      $0.leading.equalTo(self.director)
      $0.trailing.equalToSuperview().inset(10)
      $0.bottom.equalToSuperview().offset(-10)
    }

  }

}
