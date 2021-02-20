//
//  ImagesViewItem.swift
//  MyAlbum
//
//  Created by sangho Cho on 2021/02/21.
//

import Foundation
import UIKit
import SnapKit

class ImagesViewItem: UICollectionViewCell {

  // MARK: UI

  private let imgView: UIImageView = {
    let imgView = UIImageView()
    return imgView
  }()

  // MARK: initializing

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(image: UIImage) {
    self.imgView.image = image
  }


  // MARK: Layout

  private func layout() {

    self.contentView.addSubview(imgView)

    self.imgView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

}
