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

  private var apiService: CountriesListUpProtocol
  var countriesList: [Country] = []


  // MARK: Initiallizing

  init(apiService: CountriesListUpProtocol) {
    self.apiService = apiService
    self.countriesList = apiService.loadCountries() ?? []
  }
}

