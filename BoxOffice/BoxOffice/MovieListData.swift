//
//  MovieListData.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/14.
//

import Foundation

class MovieListData {
  static let shared = MovieListData()

  var movieList: [Movie] = []
  var sort: SortType = .reservation {
    didSet {
      self.sortArray()
    }
  }

  // MARK: Functions

  func sortArray() {
    switch self.sort {
    case .curation:
      self.movieList.sort(by: {$0.reservationRate > $1.reservationRate})
    case .release:
      self.movieList.sort(by: {$0.date > $1.date})
    case .reservation:
      self.movieList.sort(by: {$0.reservationGrade < $1.reservationGrade})
    }
  }

  private init() {
  }
}
