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
  let celsius: Float
  let rainfallProbability: Int

  var fahrenheitTemp: Float {
    return Float((self.celsius * 9/5) + 32)
  }

  var temperature: String {
    return "섭씨 \(celsius)도 / 화씨 \(String(format: "%.2f", fahrenheitTemp))도"
  }

  var rainProbability: String {
    return "강수 확률 \(rainfallProbability)%"
  }

  enum CodingKeys: String, CodingKey {
    case cityName = "city_name"
    case state
    case celsius
    case rainfallProbability = "rainfall_probability"
  }
}
