//
//  MovieSynopsisCell.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/15.
//

import Foundation
import UIKit
import SnapKit


class MovieSynopsisCell: UITableViewCell {

  // MARK: UI

  let synopsisTitleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.text = "줄거리"
    return label
  }()
  let synopsis: UITextView = {
    let view = UITextView()
    view.font = .systemFont(ofSize: 15)
    view.isEditable = false
    view.isScrollEnabled = false
    return view
  }()


  // MARK: Initialzing

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Set

  func set(movie: MovieInfoModel) {
    self.synopsis.text = movie.synopsis
    self.synopsis.sizeToFit()
  }


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(self.synopsisTitleLabel)
    self.contentView.addSubview(self.synopsis)

    self.synopsisTitleLabel.snp.makeConstraints{
      $0.top.equalToSuperview().inset(5)
      $0.leading.equalToSuperview().inset(5)
    }
    self.synopsis.snp.makeConstraints{
      $0.top.equalTo(self.synopsisTitleLabel.snp.bottom)
      $0.leading.equalTo(self.synopsisTitleLabel)
      $0.width.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-10)
    }
  }

}
