//
//  Double+timeStamp.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/19.
//

import Foundation

extension Double {
  func timeStamp() -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(self))
    let dateFormat = DateFormatter()

    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormat.string(from: date)
  }
}
