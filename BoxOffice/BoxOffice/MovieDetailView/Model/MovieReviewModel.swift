//
//  MovieReviewModel.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/16.
//

import Foundation

struct MoviewReviewModel: Codable {
  let rating: Double
  let timeStamp: Double
  let writer: String
  let movieID: String
  let contents: String
  let id: String

  enum CodingKeys: String, CodingKey {
    case rating
    case timeStamp = "timestamp"
    case writer
    case movieID = "movie_id"
    case contents
    case id
  }
}
