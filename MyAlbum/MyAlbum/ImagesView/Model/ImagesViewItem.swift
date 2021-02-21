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

  override var isSelected: Bool {
    didSet{
      if self.isSelected {
        self.layer.borderWidth = 5
        self.imgView.alpha = 0.6
      } else {
        self.layer.borderWidth = 0
        self.imgView.alpha = 1
      }
    }
  }


  // MARK: Layout

  private func layout() {

    self.contentView.addSubview(imgView)

    self.imgView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

}
