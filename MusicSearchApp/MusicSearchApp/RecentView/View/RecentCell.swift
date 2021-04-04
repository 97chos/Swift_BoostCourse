//
//  RecentCell.swift
//  MusicSearchApp
//
//  Created by sangho Cho on 2021/04/05.
//

import Foundation
import UIKit

class RecentCell: UITableViewCell {

  // MARK: Properties

  let title: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 17, weight: .heavy)
    label.textColor = .systemRed
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


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(self.title)

    self.title.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
  }
}
