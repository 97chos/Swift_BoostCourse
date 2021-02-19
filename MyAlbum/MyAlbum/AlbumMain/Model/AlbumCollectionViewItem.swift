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
    imageView.image = UIImage(named: "album")
    return imageView
  }()
  private let albumTitle: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    label.text = "앨범1"
    return label
  }()
  private let albumCount: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    label.text = "앨범2"
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

  // MARK: Layout

  private func layout() {
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
