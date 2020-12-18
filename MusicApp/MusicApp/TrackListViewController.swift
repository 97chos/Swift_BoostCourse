//
//  TrackListViewController.swift
//  MusicApp
//
//  Created by sangho Cho on 2020/12/18.
//

import Foundation
import UIKit


class TrackListViewController: UIViewController {

    var TrackList: [TrackModel] = []
    var tv = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        tv.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(tv)
        tv.register(MusicCell.self, forCellReuseIdentifier: "cell")

        tv.dataSource = self
        tv.delegate = self

        loadTrackList()
    }

    func loadTrackList() {
        self.TrackList = [
            TrackModel(title: "Swish", thumb: UIImage(named: "Swish")!, artist: "tyga"),
            TrackModel(title: "Dip", thumb: UIImage(named: "Dip")!, artist: "tyga"),
            TrackModel(title: "The Harlem Barber Swing", thumb: UIImage(named: "The Harlem Barber Swing")!, artist: "Jazzinuf"),
            TrackModel(title: "Believer", thumb: UIImage(named: "Believer")!, artist: "Imagine Dragon"),
            TrackModel(title: "Blue Birds", thumb: UIImage(named: "Blue Birds")!, artist: "Eevee"),
            TrackModel(title: "Best Mistake", thumb: UIImage(named: "Best Mistake")!, artist: "Ariana Grande"),
            TrackModel(title: "thank u, next", thumb: UIImage(named: "thank u, next")!, artist: "Ariana Grande"),
            TrackModel(title: "7 rings", thumb: UIImage(named: "7 rings")!, artist: "Ariana Grande")
        ]
    }
}

extension TrackListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.TrackList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MusicCell else {
            print("no identifier")
            return UITableViewCell()
        }
        let row = TrackList[indexPath.row]

        cell.title.text = row.title
        cell.artist.text = row.artist
        cell.imgView.image = row.thumb

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension TrackListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerVC = PlayerVC()
        playerVC.modalPresentationStyle = .fullScreen
        playerVC.track = TrackList[indexPath.row]
        present(playerVC, animated: true)
    }

}


