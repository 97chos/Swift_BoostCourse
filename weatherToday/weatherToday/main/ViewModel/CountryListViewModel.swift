//
//  CountryListViewModel.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation
import UIKit

class CountryListViewModel {

  // MARK: Properties

  var countriesList: [Country] = []


  // MARK: Initiallizing

  init() {
    self.decodeJson()
  }


  // MARK: JsonDecode

  func decodeJson() {
    let decoder = JSONDecoder()
    guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
      return
    }
    do {
      self.countriesList = try decoder.decode([Country].self, from: dataAsset.data)
    } catch {
      print(error.localizedDescription)
    }
  }
  
}

