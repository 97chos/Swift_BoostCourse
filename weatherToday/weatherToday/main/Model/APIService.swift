//
//  APIService.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation
import UIKit

protocol CountriesListUpProtocol {
  func loadCountries() -> [Country]?
}

class APIService: CountriesListUpProtocol {

  func loadCountries() -> [Country]? {
    let decoder = JSONDecoder()
    guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
      return nil
    }
    do {
      return try decoder.decode([Country].self, from: dataAsset.data)
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
}
