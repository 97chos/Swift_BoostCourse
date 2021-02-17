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
    let imageView = UIImageView(frame: CGRect.zero)
    return imageView
  }()
  private let countryLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()
  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let rainProbabilityLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()


  // MARK: Initializing

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.accessoryType = .disclosureIndicator
    self.layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(city: City) {
    self.countryLabel.text = city.cityName
    self.temperatureLabel.text = city.temperature
    self.rainProbabilityLabel.text = city.rainProbability

    self.countryLabel.sizeToFit()
    self.temperatureLabel.sizeToFit()
    self.rainProbabilityLabel.sizeToFit()

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


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(weatherImg)
    self.contentView.addSubview(countryLabel)
    self.contentView.addSubview(temperatureLabel)
    self.contentView.addSubview(rainProbabilityLabel)

    self.weatherImg.snp.makeConstraints{
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(10)
      $0.height.equalTo(self.contentView.snp.height).multipliedBy(0.8)
      $0.width.equalTo(self.contentView.snp.height).multipliedBy(0.8)
    }
    self.temperatureLabel.snp.makeConstraints{
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(self.weatherImg.snp.trailing).offset(10)
    }
    self.countryLabel.snp.makeConstraints{
      $0.bottom.equalTo(self.temperatureLabel.snp.top).offset(-10)
      $0.leading.equalTo(self.temperatureLabel)
    }
    self.rainProbabilityLabel.snp.makeConstraints{
      $0.top.equalTo(self.temperatureLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.temperatureLabel)
    }
  }
}
