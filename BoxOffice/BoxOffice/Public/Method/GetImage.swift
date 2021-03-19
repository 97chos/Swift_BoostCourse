//
//  GetImage.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/15.
//

import Foundation
import UIKit

class GetImage {
  static func getThumbImage<T: MovieDataProtocol>(_ movie: T) -> UIImage? {
    guard let url = URL(string: movie.thumb) else { return nil }
    do {
      let imageData = try Data(contentsOf: url)
      return UIImage(data: imageData)
    } catch(let error) {
      print(error.localizedDescription)
      return nil
    }
  }

  static func getGradeImage<T: MovieDataProtocol>(_ movie: T) -> UIImage? {
    switch movie.grade {
    case 12:
      return UIImage(named: "ic_12")
    case 15:
      return UIImage(named: "ic_15")
    case 19:
      return UIImage(named: "ic_19")
    case 0:
      return UIImage(named: "ic_allages")
    default:
      return nil
    }
  }
}

