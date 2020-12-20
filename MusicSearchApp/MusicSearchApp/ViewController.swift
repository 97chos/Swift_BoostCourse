//
//  ViewController.swift
//  MusicSearchApp
//
//  Created by sangho Cho on 2020/12/20.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var searchBar: UISearchBar!
    var tv = UITableView()
    var tracks = [Track]()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 56))
        searchBar.barTintColor = .systemPink
        searchBar.placeholder = "가수명을 입력하세요"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self

        self.tv.register(ResultCell.self, forCellReuseIdentifier: "cell")

        tv.dataSource = self
        tv.delegate = self

        self.view.addSubview(tv)
        self.view.addSubview(searchBar)

        tv.tableFooterView = UIView()
    }

    override func viewDidLayoutSubviews() {
        searchBar.frame.origin = CGPoint(x: 0, y: self.view.safeAreaInsets.top)
        self.tv.frame = CGRect(x: 0, y: self.searchBar.frame.height + self.view.safeAreaInsets.top, width: self.view.frame.width, height: self.view.safeAreaLayoutGuide.layoutFrame.height - self.searchBar.frame.height)
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

        cell.configure(data: tracks[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()

        guard let previewURL = URL(string: tracks[indexPath.row].previewUrl) else { return }

        let playerViewController = AVPlayerViewController()

        let player = AVPlayer(url: previewURL)
        player.play()
        playerViewController.player = player

        present(playerViewController, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()

        guard let searchText = searchBar.text, !(searchText.isEmpty) else { return }

        let url = "https://itunes.apple.com/search?media=music&entity=musicVideo"
        var Urlcomponet = URLComponents(string: url)
        let queryItem = URLQueryItem(name: "term", value: searchText)
        Urlcomponet?.queryItems?.append(queryItem)

        guard let requestURL = Urlcomponet?.url else { return }

        let session = URLSession(configuration: .default)
        session.dataTask(with: requestURL, completionHandler: { [weak self] data, response, error in
            guard let strongSelf = self else { return }

            // 클라이언트 에러
            guard error == nil else { return }

            // 서버 사이드 에러
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200..<300
            guard successRange.contains(statusCode) else {
                // 서버 사이드 에러 핸들링
                return
            }

            guard let resultData = data else { return }
            // Data -> Obejct로 파싱
            strongSelf.tracks = strongSelf.parse(data: resultData) ?? []
            DispatchQueue.main.async {
                strongSelf.tv.reloadData()
                // 테이블 뷰 스크롤 맨 위로 이동
                strongSelf.tv.setContentOffset(CGPoint.zero, animated: true)
            }
        }).resume()
    }
}

extension ViewController {
    func parse(data: Data) -> [Track]? {

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(Response.self, from: data)
            let trackList = response.results
            return trackList
        } catch {
            print("----> error:\(error.localizedDescription)")
            return nil
        }
    }
}
