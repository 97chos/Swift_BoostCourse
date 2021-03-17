//
//  RegitReviewModel.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/17.
//

import Foundation

struct RegitReviewModel: Encodable {
  let rating: Double
  let writer: String
  let movieId: String
  let contents: String

  enum CodingKeys: String, CodingKey {
    case rating, writer, contents
    case movieId = "movie_id"
  }
}

struct ReviewModel: Codable {
  let rating: Double
  let timeStamp: Double
  let writer: String
  let movieId: String
  let contents: String

  enum CodingKeys: String, CodingKey {
    case rating, writer, contents
    case timeStamp = "timestamp"
    case movieId = "movie_id"
  }
}
