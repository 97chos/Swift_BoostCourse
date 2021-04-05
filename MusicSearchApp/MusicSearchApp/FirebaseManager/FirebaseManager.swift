//
//  FirebaseManager.swift
//  MusicSearchApp
//
//  Created by sangho Cho on 2021/04/05.
//

import Foundation
import Firebase

enum FirebaseKey {
  static let search = "searchHistory"
  static let watch = "watchHistory"
}

class FirebaseManager {

  // MARK: Properties

  static let shared: FirebaseManager = FirebaseManager()
  let rootRef = Database.database().reference()
  var searchHistory: [String] = []
  var watchHistory: [Track] = []


  // MARK: Initializing

  private init() {}


  // MARK: Send Data To Server

  func addSearchHistory(keyword: String) {
    self.searchHistory.insert(keyword, at: 0)
    self.rootRef.child(FirebaseKey.search).setValue(self.searchHistory)
  }

  func addWatchHistory(track: Track) {
    self.watchHistory.insert(track, at: 0)
    let tracks: [[String: Any]] = self.watchHistory.map{ $0.toDictionary }
    self.rootRef.child(FirebaseKey.watch).setValue(tracks)
  }


  // MARK: Get Data From Server

  func fetchSearchHistory(completion: @escaping () -> Void) {
    self.rootRef.child(FirebaseKey.search).observeSingleEvent(of: .value) { snapShot in
      guard let searches = snapShot.value as? [String] else { return }
      self.searchHistory = Array(searches[0...2])

      DispatchQueue.main.async {
        completion()
      }
    }
  }

  func fetchWatchHistory(completion: @escaping () -> Void) {
    self.rootRef.child(FirebaseKey.watch).observeSingleEvent(of: .value) { snapShot in
      guard let watches = snapShot.value as? [[String : Any]] else { return }
      do {
        let data = try JSONSerialization.data(withJSONObject: watches, options: [])
        let tracks = try JSONDecoder().decode([Track].self, from: data)
        self.watchHistory = Array(tracks[0...2])

        DispatchQueue.main.async {
          completion()
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }

}
