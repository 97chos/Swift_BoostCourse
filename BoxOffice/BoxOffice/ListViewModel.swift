//
//  ListViewModel.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/13.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
  case urlError
  case clientError
  case responseError
  case parseError

  var description: String {
    switch self {
    case .clientError: return "클라이언트 에러입니다."
    case .parseError: return "데이터 파싱 에러입니다."
    case .responseError: return "응답 에러입니다."
    case .urlError: return "URL 에러입니다."
    }
  }
}

enum SortType: String {
  case reservation = "예매율"
  case curation = "큐레이션"
  case release = "개봉일"
}

class ListViewModel {

  // MARK: Properties

  var movieList: [Movie] = []
  let url: URL? = URL(string: "https://connect-boxoffice.run.goorm.io/movies")
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

  // MARK: API Call

  func loadMovies(completion: @escaping (Result<([Movie]),Error>) -> Void) {
    guard let url = self.url else {
      completion(.failure(APIError.urlError))
      return
    }

    let urlRequest = URLRequest(url: url)

    URLSession(configuration: .default).dataTask(with: urlRequest) { data, response, error in
      guard error == nil else {
        completion(.failure(APIError.clientError))
        return
      }

      guard let resultData = data else {
        completion(.failure(APIError.responseError))
        return
      }

      do {
        let result = try JSONDecoder().decode(rawData.self, from: resultData)
        let movies = result.movies
        completion(.success(movies))
      } catch {
        completion(.failure(APIError.parseError))
        return
      }
    }.resume()
  }
}
