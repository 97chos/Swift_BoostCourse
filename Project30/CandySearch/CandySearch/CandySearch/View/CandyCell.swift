//
//  CandyCell.swift
//  CandySearch
//
//  Created by sangho Cho on 2021/05/02.
//

import Foundation
import UIKit


class CandyCell: UITableViewCell {

  // MARK: Initializing

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(candy: Candy) {
    self.textLabel?.text = candy.name
    self.detailTextLabel?.text = "\(candy.type)"
  }
}
