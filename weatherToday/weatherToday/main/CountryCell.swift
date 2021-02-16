//
//  CountryCell.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation
import UIKit
import SnapKit

class CountryCell: UITableViewCell {

  // MARK: Initialize

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.accessoryType = .disclosureIndicator
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: SetCell

  func set(country: country) {
    self.imageView?.image = UIImage(named: "flag_\(country.assetName)")
    self.textLabel?.text = country.countryName
  }

  override func prepareForReuse() {
    self.imageView?.image = nil
    self.textLabel?.text = nil
  }
}
