//
//  CityListViewModel.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation
import UIKit

class CityListViewModel {

  // MARK: Properties

  var cityList: [City] = []
  var country: String!


  // MARK: Initializing

  init(cityCode: String, country: String) {
    self.decodeJsonData(cityCode)
    self.country = country
  }


  // MARK: Functions

  private func decodeJsonData(_ cityCode: String) {
    guard let dataAsset: NSDataAsset = NSDataAsset(name: "\(cityCode)") else {
      return
    }

    let decoder = JSONDecoder()
    do {
      self.cityList = try decoder.decode([City].self, from: dataAsset.data)
    } catch {
      print(error.localizedDescription)
    }
  }

}
