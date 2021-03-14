//
//  MovieListModel.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/13.
//

import Foundation

struct rawData: Codable {
  let orderType: Int
  let movies: [Movie]

  enum CodingKeys: String, CodingKey {
    case orderType = "order_type"
    case movies
  }
}

struct Movie: Codable {
  let grade: Int
  let thumb: String
  let reservationGrade: Int
  let title: String
  let reservationRate: Double
  let userRating: Double
  let date: String
  let id: String

  lazy var movieInformation: String = "평점: \(self.userRating) 예매순위: \(self.reservationGrade) 예매율: \(reservationRate)"
  lazy var movieInformationCollection: String = "\(self.reservationGrade)위(\(self.userRating)) / \(self.reservationRate)%"

  enum CodingKeys: String, CodingKey {
    case grade
    case thumb
    case reservationGrade = "reservation_grade"
    case title
    case reservationRate = "reservation_rate"
    case userRating = "user_rating"
    case date
    case id
  }
}
