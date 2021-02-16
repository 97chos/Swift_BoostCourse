//
//  CountriesModel.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation

struct country: Codable {
  let countryName: String
  let assetName: String

  enum CodingKeys: String, CodingKey {
    case countryName = "korean_name"
    case assetName = "asset_name"
  }
}
