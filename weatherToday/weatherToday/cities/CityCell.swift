//
//  CityCell.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation
import UIKit
import SnapKit

class CityCell: UITableViewCell {

  // MARK: UI

  private let weatherImg: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  private let countryLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()
  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13)
    return label
  }()
  private let rainProbabilityLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13)
    return label
  }()


  // MARK: Initializing

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(city: City) {
    self.countryLabel.text = city.cityName
    self.temperatureLabel.text = city.temperature
    self.rainProbabilityLabel.text = city.rainProbability

    switch city.state {
    case 10 :
      self.weatherImg.image = UIImage(named: "sunny")
    case 11 :
      self.weatherImg.image = UIImage(named: "cloudy")
    case 12 :
      self.weatherImg.image = UIImage(named: "rainy")
    case 13 :
      self.weatherImg.image = UIImage(named: "snowy")
    default:
      break
    }
  }


}
