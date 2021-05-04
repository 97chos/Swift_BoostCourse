//
//  chunked.swift
//  Calculator
//
//  Created by sangho Cho on 2021/05/03.
//

import Foundation

extension Array {
  func chunked(into size: Int) -> [[Element]] {
    return stride(from: 0, to: self.count, by: size).map{
      Array(self[$0..<Swift.min($0 + size, self.count)])
    }
  }
}
