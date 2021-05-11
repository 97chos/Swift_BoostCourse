//
//  RSSItem.swift
//  SimpleRSSReader
//
//  Created by sangho Cho on 2021/05/11.
//

import Foundation


enum CellState {
  case expanded
  case collapsed
}

struct RSSItem {
  let title: String
  let description: String
  let pubDate: String
  var cellState: CellState = .collapsed
}
