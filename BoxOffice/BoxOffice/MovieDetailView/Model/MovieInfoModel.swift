//
//  MovieInfoModel.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/15.
//

import Foundation

struct MovieInfoModel: Codable, MovieDataProtocol {
  let audience: Int
  let actor: String
  let duration: Int
  let director: String
  let synopsis: String
  let genre: String
  let grade: Int
  let thumb: String
  let reservationGrade: Int
  let title: String
  let reservationRate: Double
  let userRating: Double
  let date: String
  let id: String

  enum CodingKeys: String, CodingKey {
    case audience
    case actor
    case duration
    case director
    case synopsis
    case genre
    case grade
    case thumb = "image"
    case reservationGrade = "reservation_grade"
    case title
    case reservationRate = "reservation_rate"
    case userRating = "user_rating"
    case date
    case id
  }
}
