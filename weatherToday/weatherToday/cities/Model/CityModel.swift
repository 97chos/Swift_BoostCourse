//
//  CityModel.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation

struct City: Codable {
  let cityName: String
  let state: Int
  let celsius: Int
  let rainfallProbability: Int

  enum CodingKeys: String, CodingKey {
    case cityName, state, celsius
    case rainfallProbability = "rainfall_probability"
  }
}
