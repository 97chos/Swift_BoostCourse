//
//  MovieReviewCell.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/16.
//

import Foundation
import UIKit
import SnapKit

class MovieReviewCell: UITableViewCell {

  // MARK: UI

  private let profileImage: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "ic_user_loading")
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  private let nickname: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let date: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    label.textColor = .darkGray
    return label
  }()
  private let review: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 17)
    return view
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

  func set(review: MoviewReviewModel) {
    self.nickname.text = review.writer
    self.date.text = review.timeStamp.timeStamp()
    self.review.text = review.contents
  }


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(self.profileImage)
    self.contentView.addSubview(self.nickname)
    self.contentView.addSubview(self.date)
    self.contentView.addSubview(self.review)

    self.profileImage.snp.makeConstraints{
      $0.top.equalToSuperview().inset(10)
      $0.leading.equalToSuperview().inset(10)
      $0.width.height.equalTo(70)
    }
    self.nickname.snp.makeConstraints{
      $0.top.equalTo(self.profileImage)
      $0.leading.equalTo(self.profileImage.snp.trailing).offset(5)
    }
    self.date.snp.makeConstraints{
      $0.top.equalTo(self.nickname.snp.bottom).offset(5)
      $0.leading.equalTo(self.nickname)
    }
    self.review.snp.makeConstraints{
      $0.leading.equalTo(self.nickname)
      $0.trailing.equalToSuperview()
      $0.top.equalTo(self.date.snp.bottom).offset(5)
      $0.bottom.equalToSuperview().offset(-10)
    }
  }
}
