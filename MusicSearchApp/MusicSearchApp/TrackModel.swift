//
//  TrackModel.swift
//  MusicSearchApp
//
//  Created by sangho Cho on 2020/12/20.
//

import Foundation
import UIKit


struct Response: Codable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Codable {
    var title: String
    var artistName: String
    var thumbnail: String
    let previewUrl: String?

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artistName = "artistName"
        case thumbnail = "artworkUrl30"
        case previewUrl = "previewUrl"
    }
}
