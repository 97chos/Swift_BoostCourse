//
//  ViewModel.swift
//  SimpleRSSReader
//
//  Created by sangho Cho on 2021/05/12.
//

import Foundation

class ViewModel {

  // MARK: Properties

  private let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
  private let feedParser = RSSParser()
  var rssItems: [RSSItem]?


  // MARK: Parse Function

  func parseRSS(completion: @escaping () -> Void) {
    self.feedParser.parseFeed(feedURL: self.feedURL) { [weak self] rssItems in
      guard let self = self else { return }
      self.rssItems = rssItems

      DispatchQueue.main.async {
        completion()
      }
    }
  }
}
