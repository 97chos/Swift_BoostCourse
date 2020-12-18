//
//  PlayerVC.swift
//  MusicApp
//
//  Created by sangho Cho on 2020/12/18.
//

import Foundation
import UIKit
import SnapKit
import AVFoundation

class PlayerVC: UIViewController {

    var track: Track!
    var avplayer: AVPlayer!
    var timeObserver: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
