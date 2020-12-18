//
//  TrackModel.swift
//  MusicApp
//
//  Created by sangho Cho on 2020/12/18.
//

import Foundation
import UIKit
import AVFoundation

class TrackModel {
    var title: String
    var thumb: UIImage
    var artist: String

    // 연산 프로퍼티
    var asset: AVAsset {
        let path = Bundle.main.path(forResource: title, ofType: "mov")!
        let url = URL(fileURLWithPath: path)
        let asset = AVAsset(url: url)
        return asset
    }

    init(title:String, thumb: UIImage, artist : String) {
        self.title = title
        self.thumb = thumb
        self.artist = artist
    }

}
