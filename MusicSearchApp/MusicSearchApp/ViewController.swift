//
//  ViewController.swift
//  MusicSearchApp
//
//  Created by sangho Cho on 2020/12/20.
//

import UIKit

class ViewController: UIViewController {

    var searchBar: UISearchBar!
    var tv = UITableView()
    var tracks = [Track]()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = UISearchBar()
        searchBar.frame.size = CGSize(width: self.view.frame.width, height: 60)
        searchBar.barTintColor = .systemTeal

        self.tv.frame = CGRect(x: 0, y: self.searchBar.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        self.tv.register(ResultCell.self, forCellReuseIdentifier: "cell")

        tv.dataSource = self
        tv.delegate = self
        searchBar.delegate = self

        self.view.addSubview(tv)
        self.view.addSubview(searchBar)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ResultCell else {
            return UITableViewCell() as! ResultCell
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UISearchBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

