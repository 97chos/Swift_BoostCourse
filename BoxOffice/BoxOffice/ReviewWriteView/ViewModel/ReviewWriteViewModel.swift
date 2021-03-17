//
//  ReviewWriteViewModel.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/17.
//

import Foundation

class ReviewWriteViewModel {

  // MARK: Properties

  let movie: MovieInfoModel


  // MARK: Initializing

  init(movie: MovieInfoModel) {
    self.movie = movie
  }


  // MARK: Functions

  func done(rating: Float, writer: String, contents: String, completion: @escaping (Result<(ReviewModel),Error>) -> Void) {

    guard let url = URL(string: "http://connect-boxoffice.run.goorm.io/comment") else { return }
    var request = URLRequest(url: url)
    let body = RegitReviewModel(rating: Double(rating), writer: writer, movieId: self.movie.id, contents: contents)

    let param = try? JSONEncoder().encode(body)

    request.httpMethod = "POST"
    request.httpBody = param

    URLSession(configuration: .default).dataTask(with: request) { data, response, error in
      guard error == nil else {
        completion(.failure(APIError.clientError))
        return
      }
      guard let resultData = data else {
        completion(.failure(APIError.responseError))
        return
      }
      do {
        let result = try JSONDecoder().decode(ReviewModel.self, from: resultData)
        completion(.success(result))
      } catch {
        completion(.failure(APIError.responseError))
      }
    }.resume()
  }
}
