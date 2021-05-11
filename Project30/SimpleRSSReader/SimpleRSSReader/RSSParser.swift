//
//  APIService.swift
//  SimpleRSSReader
//
//  Created by sangho Cho on 2021/05/11.
//

import Foundation


class RSSParser: NSObject {

  // MARK: Properties

  var rssItems: [RSSItem] = []

  var currentElement = ""
  var currentTitle = "" {
    didSet {
      currentTitle = currentTitle.trimmingCharacters(in: .whitespacesAndNewlines)
    }
  }
  var currentDescription = "" {
    didSet {
      currentDescription = currentDescription.trimmingCharacters(in: .whitespacesAndNewlines)
    }
  }
  var currentPubDate = "" {
    didSet {
      currentPubDate = currentPubDate.trimmingCharacters(in: .whitespacesAndNewlines)
    }
  }
  var parserCompletionHandler: (([RSSItem]) -> Void)?


  // MARK: Functions

  func parseFeed(feedURL: String, completionHandleer: (([RSSItem]) -> Void)?) -> Void {
    self.parserCompletionHandler = completionHandleer

    guard let feedURL = URL(string: feedURL) else { return }

    URLSession.shared.dataTask(with: feedURL) { data, response, error in

      if let error = error {
        print(error)
        return
      } else if let data = data {
        let paser = XMLParser(data: data)
        paser.delegate = self
        paser.parse()
      }
    }.resume()
  }

}

extension RSSParser: XMLParserDelegate {

  func parserDidStartDocument(_ parser: XMLParser) {
    rssItems.removeAll()
  }

  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    self.currentElement = elementName

    if self.currentElement == "item" {
      self.currentTitle = ""
      self.currentDescription = ""
      self.currentPubDate = ""
    }
  }

  func parser(_ parser: XMLParser, foundCharacters string: String) {
    switch currentElement {
    case "title":
      self.currentTitle += string
    case "description":
      self.currentDescription += string
    case "pubDate":
      self.currentPubDate += string
    default:
      break
    }
  }

  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "item" {
      let rssItem = RSSItem(title: self.currentTitle, description: self.currentDescription, pubDate: self.currentPubDate)
      self.rssItems.append(rssItem)
    }
  }

  func parserDidEndDocument(_ parser: XMLParser) {
    self.parserCompletionHandler?(self.rssItems)
  }

  func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    print(parseError.localizedDescription)
  }
}

