//
//  CandyModel.swift
//  CandySearch
//
//  Created by sangho Cho on 2021/05/01.
//

import Foundation

enum CandyType: String {
  case chocolate = "Chocolate"
  case hard = "Hard"
  case other = "Other"
}

struct Candy {
  let type: CandyType
  let name: String
}
