//
//  ViewController.swift
//  Interest
//
//  Created by sangho Cho on 2021/05/12.
//

import UIKit
import SnapKit

class InterestCollcetionViewCell: UICollectionViewCell {

  // MARK: UI

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byTruncatingTail
    return label
  }()
  private let titleView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    return view
  }()


  // MARK: Initializing

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configuration()
    self.layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Set

  private func configuration() {
    self.contentView.backgroundColor = .systemGray6
  }

  func set(interest: Interest) {
    self.titleLabel.text = interest.title
    self.imageView.image = interest.featuredImage
  }


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(self.imageView)
    self.contentView.addSubview(self.titleView)
    self.titleView.addSubview(self.titleLabel)

    self.layer.cornerRadius = self.frame.width / 10
    self.layer.masksToBounds = true

    self.imageView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.8)
    }
    self.titleView.snp.makeConstraints {
      $0.top.equalTo(self.imageView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
    self.titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(10)
    }
  }
}

