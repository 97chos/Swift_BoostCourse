//
//  TableSectionHeaderView.swift
//  MusicSearchApp
//
//  Created by sangho Cho on 2021/04/04.
//

import Foundation
import UIKit
import SnapKit

class TableSectionHeaderView: UITableViewHeaderFooterView {

  // MARK: UI

  var title: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .heavy)
    return label
  }()


  // MARK: Initialzing

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Layout

  private func layout() {
    self.contentView.backgroundColor = .white
    self.contentView.addSubview(self.title)

    self.title.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
  }
}
