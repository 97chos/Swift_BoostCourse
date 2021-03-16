//
//  DetailViewModel.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/14.
//

import Foundation

protocol layoutUpdateDelegate: class {
  func layoutReload()
}

enum DetailViewSections {
  case movieInformation
  case synopsis
  case crew
  case review
}


class DetailViewModel {


  // MARK: Properties

  let sectionList: [DetailViewSections] = [.movieInformation,.synopsis,.crew,.review]
  var movie: [MovieInfoModel] = []
  var moviewReviews: [MoviewReviewModel] = []

  let loadMovieUrlString = "connect-boxoffice.run.goorm.io/movie?"
  let loadReviewUrlString = "connect-boxoffice.run.goorm.io/comments?"
  weak var delegate: layoutUpdateDelegate?


  // MARK: Initializing

  init(movieId: String) {
    self.setData(id: movieId)
    self.loadReviews(id: movieId)
  }


  // MARK: Functions

  func setData(id: String) {
    var components = URLComponents(string: self.loadMovieUrlString)
    components?.scheme = "http"
    components?.queryItems?.append(URLQueryItem(name: "id", value: id))
    guard let componentsURL = components?.url else { return }

    let request: URLRequest = URLRequest(url: componentsURL)

    URLSession(configuration: .default).dataTask(with: request) { data, response, error in
      guard error == nil else {
        return
      }
      guard let resultData = data else {
        return
      }

      do {
        let result = try JSONDecoder().decode(MovieInfoModel.self, from: resultData)
        self.movie = [result]
      } catch {
        return
      }
    }.resume()
  }

  func loadReviews(id: String) {
    var components = URLComponents(string: self.loadReviewUrlString)
    components?.scheme = "http"
    components?.queryItems?.append(URLQueryItem(name: "id", value: id))
    guard let componentsURL = components?.url else { return }

    let request: URLRequest = URLRequest(url: componentsURL)

    URLSession(configuration: .default).dataTask(with: request) { data, response, error in
      guard error == nil else {
        return
      }
      guard let resultData = data else {
        return
      }

      do {
        let result = try JSONDecoder().decode([MoviewReviewModel].self, from: resultData)
        self.moviewReviews = result
        DispatchQueue.main.async {
          self.delegate?.layoutReload()
        }
      } catch {
        return
      }
    }.resume()
  }
  
}
