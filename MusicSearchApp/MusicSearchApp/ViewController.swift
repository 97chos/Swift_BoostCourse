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

        viewSafeAreaInsetsDidChange()

        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 56))
        searchBar.barTintColor = .systemTeal
        searchBar.delegate = self

        self.tv.register(ResultCell.self, forCellReuseIdentifier: "cell")

        tv.dataSource = self
        tv.delegate = self

        self.view.addSubview(tv)
        self.view.addSubview(searchBar)
    }

    override func viewDidLayoutSubviews() {
        searchBar.frame.origin = CGPoint(x: 0, y: self.view.safeAreaInsets.top)
        self.tv.frame = CGRect(x: 0, y: self.searchBar.frame.height + self.view.safeAreaInsets.top, width: self.view.frame.width, height: self.view.frame.height)
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

