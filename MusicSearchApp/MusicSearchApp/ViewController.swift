//
//  ViewController.swift
//  MusicSearchApp
//
//  Created by sangho Cho on 2020/12/20.
//

import UIKit
import AVKit
import SnapKit

class ViewController: UIViewController {

  // MARK: Properties

  private var tracks = [Track]()
  private let recentVC = RecentViewController()


  // MARK: UI

  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 56))
    searchBar.barTintColor = .systemPink
    searchBar.placeholder = "가수명을 입력하세요."
    searchBar.searchTextField.backgroundColor = .systemBackground
    searchBar.delegate = self
    return searchBar
  }()
  var tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()
  private let containerView: UIView = {
    let view = UIView()
    return view
  }()


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureViews()
    self.layout()
    self.addChildView()
  }

  override func viewDidLayoutSubviews() {
    self.searchBar.frame.origin = CGPoint(x: 0, y: self.view.safeAreaInsets.top)
  }


  // MARK: Configure

  private func configureViews() {
    self.view.backgroundColor = .systemBackground
    self.configureTableView()
  }

  private func configureTableView() {
    self.tableView.register(ResultCell.self, forCellReuseIdentifier: "cell")
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.tableFooterView = UIView()
  }


  // MARK: Functions

  private func addChildView() {
    self.addChild(recentVC)

    recentVC.didMove(toParent: self)
    recentVC.view.frame = self.containerView.frame
    recentVC.delegate = self
    self.containerView.addSubview(recentVC.view)
  }

  private func parse(data: Data) -> [Track]? {
    do {
      let decoder = JSONDecoder()
      let response = try decoder.decode(Response.self, from: data)
      let trackList = response.results
      return trackList
    } catch {
      print("----> error:\(error.localizedDescription)")
      debugPrint(error)
      return nil
    }
  }

  private func search(keyword: String) {
    let url = "https://itunes.apple.com/search?media=music&entity=musicVideo"
    var Urlcomponet = URLComponents(string: url)
    let queryItem = URLQueryItem(name: "term", value: keyword)
    Urlcomponet?.queryItems?.append(queryItem)
    guard let requestURL = Urlcomponet?.url else { return }

    URLSession(configuration: .default).dataTask(with: requestURL) { [weak self] data, response, error in
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
        strongSelf.tableView.reloadData()
        // 테이블 뷰 스크롤 맨 위로 이동
        strongSelf.tableView.setContentOffset(CGPoint.zero, animated: true)
      }
    }.resume()
  }

  private func play(track: Track) {
    guard let previewURL = URL(string: track.previewUrl ?? "") else { return }
    let playerViewController = AVPlayerViewController()
    let player = AVPlayer(url: previewURL)

    player.play()
    playerViewController.player = player

    present(playerViewController, animated: true)
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(tableView)
    self.view.addSubview(searchBar)
    self.view.addSubview(containerView)

    self.tableView.snp.makeConstraints{
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(self.searchBar.frame.height)
      $0.leading.trailing.bottom.equalToSuperview()
    }
    self.containerView.snp.makeConstraints{
      $0.edges.equalTo(self.tableView)
    }
  }
}


// MARK: Tableview DataSource & Delegate

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
    tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)

    let track = self.tracks[indexPath.row]
    self.play(track: track)
    FirebaseManager.shared.addWatchHistory(track: track)
    self.recentVC.tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .none)
  }
}


// MARK: SearchBar Delegate

extension ViewController: UISearchBarDelegate {
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.searchBar.resignFirstResponder()

    guard let searchText = searchBar.text, !(searchText.isEmpty) else { return }
    self.search(keyword: searchText)
    FirebaseManager.shared.addSearchHistory(keyword: searchText)
    self.recentVC.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .none)

    if !searchText.isEmpty {
      self.containerView.isHidden = true
    }
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText == "" {
      self.containerView.isHidden = false
    }
  }
}


// MARK: History Select Delegate

extension ViewController: HistorySelectDelegate {
  func searchHistroySelected(keyword: String) {
    self.search(keyword: keyword)
    self.searchBar.text = keyword
    self.containerView.isHidden = true
  }

  func watchHistorySelected(track: Track) {
    self.play(track: track)
  }
}
