//
//  WeatherDetailViewModel.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation

class WeatherDetailViewModel {

  // MARK: Properties

  let city: City!


  // MARK: Initializing

  init(city: City) {
    self.city = city
  }


  // MARK: Functions

  func weatherInformation() -> (String, String) {
    switch self.city.state {
    case 10 :
      return ("sunny","맑음")
    case 11 :
      return ("cloudy","흐림")
    case 12 :
      return ("rainy","비")
    case 13 :
      return ("snowy","눈")
    default:
      return ("","")
    }
  }
}
