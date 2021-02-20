//
//  AlbumCollectionViewItem.swift
//  MyAlbum
//
//  Created by sangho Cho on 2021/02/19.
//

import Foundation
import UIKit
import SnapKit

class AlbumCollectionViewItem: UICollectionViewCell {

  // MARK: UI

  private let ImgView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  private let albumTitle: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()
  private let albumCount: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()

  // MARK: Initializing

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(image: UIImage, title: String, count: Int) {

    self.ImgView.image = image
    self.albumTitle.text = title
    self.albumCount.text = "\(count)"

  }

  // MARK: Layout

  private func layout() {

    self.backgroundColor = .systemBackground


    self.ImgView.layer.cornerRadius = self.contentView.frame.width / 7
    self.ImgView.layer.borderWidth = 0
    self.ImgView.layer.masksToBounds = true

    self.contentView.addSubview(ImgView)
    self.contentView.addSubview(albumTitle)
    self.contentView.addSubview(albumCount)

    self.ImgView.snp.makeConstraints{
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.width.equalToSuperview()
      $0.height.equalTo(self.ImgView.snp.width)
    }

    self.albumTitle.snp.makeConstraints{
      $0.top.equalTo(self.ImgView.snp.bottom).offset(5)
      $0.leading.equalToSuperview()
    }

    self.albumCount.snp.makeConstraints{
      $0.top.equalTo(self.albumTitle.snp.bottom).offset(5)
      $0.leading.equalToSuperview()
    }

  }
}
