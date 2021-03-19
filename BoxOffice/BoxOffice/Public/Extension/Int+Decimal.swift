//
//  Double+Decimal.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/19.
//

import Foundation
extension Int {
  func cutDecimal() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
}

