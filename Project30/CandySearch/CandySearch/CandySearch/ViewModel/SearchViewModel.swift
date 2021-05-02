//
//  SearchViewModel.swift
//  CandySearch
//
//  Created by sangho Cho on 2021/05/02.
//

import Foundation

class SearchViewModel {

  // MARK: Properties

  private let candies: [Candy] = [
    Candy(type: .chocolate, name: "Chocolate Bar"),
    Candy(type: .chocolate, name: "Chocolate Chip"),
    Candy(type: .chocolate, name: "Dark Chocolate"),
    Candy(type: .hard, name: "Lollipop"),
    Candy(type: .hard, name: "Jaw Breaker"),
    Candy(type: .other, name: "Caramel"),
    Candy(type: .other, name: "Sour Chew"),
    Candy(type: .other, name: "Gummi Bear")
  ]

  lazy var filteredCandies: [Candy] = self.candies


  // MARK: Functions

  func filterContent(_ text: String?, _ scope: String = "All") {
    guard let text = text else { return }
    self.filteredCandies = candies.filter {
      if $0.type.rawValue != scope && scope != "All" {
        return false
      }

      return $0.name.lowercased().contains(text.lowercased()) || text == ""
    }

  }
  
}
