//
//  CitiesAPIService.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation
import UIKit

protocol CitiesListUpProtocol {
  func loadCities(countryCode: String) -> [City]?
}

class CitiesAPIService: CitiesListUpProtocol {

  func loadCities(countryCode: String) -> [City]? {
    guard let dataAsset: NSDataAsset = NSDataAsset(name: "\(countryCode)") else {
      return nil
    }

    let decoder = JSONDecoder()
    do {
      return try decoder.decode([City].self, from: dataAsset.data)
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
}
