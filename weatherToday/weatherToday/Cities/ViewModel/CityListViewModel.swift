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

  private var apiService: CitiesListUpProtocol!
  var cityList: [City] = []
  var country: String!


  // MARK: Initializing

  init(apiService: CitiesListUpProtocol, country: Country) {
    self.apiService = apiService
    self.cityList = apiService.loadCities(countryCode: country.assetName) ?? []
    self.country = country.countryName
  }
}
