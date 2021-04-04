//
//  RecentViewController.swift
//  MusicSearchApp
//
//  Created by sangho Cho on 2021/04/04.
//

import Foundation
import SnapKit
import Firebase
import UIKit

protocol HistorySelectDelegate: class {
  func searchHistroySelected(keyword: String)
  func watchHistorySelected(track: Track)
}

class RecentViewController: UIViewController {

  // MARK: Properties

  private let sections: [String] = ["Recent Search","Recent Watch"]
  weak var delegate: HistorySelectDelegate?


  // MARK: UI

  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.tableFooterView = UIView()
    return tableView
  }()


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didMove(toParent parent: UIViewController?) {
    super.didMove(toParent: parent)
    self.configureViews()
    self.layout()
  }


  // MARK: configure

  private func configureViews() {
    self.view.backgroundColor = .systemBackground
    self.configureTableView()
    self.fetchHistory()
  }

  private func configureTableView() {
    self.tableView.register(RecentCell.self, forCellReuseIdentifier: "cell")
    self.tableView.register(TableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "section")
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }

  private func fetchHistory() {
    FirebaseManager.shared.fetchSearchHistory {
      self.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
    }
    FirebaseManager.shared.fetchWatchHistory {
      self.tableView.reloadData()
    }
  }

  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.tableView)

    self.tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

extension RecentViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.sections.count
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "section") as? TableSectionHeaderView
    headerView?.title.text = self.sections[section]
    
    return headerView
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 65
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return FirebaseManager.shared.searchHistory.count
    case 1:
      return FirebaseManager.shared.watchHistory.count
    default:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RecentCell else {
      return UITableViewCell()
    }

    switch indexPath.section {
    case 0:
      let keyword = FirebaseManager.shared.searchHistory[indexPath.row]
      cell.title.text = keyword
    case 1:
      let trackTitle = FirebaseManager.shared.watchHistory[indexPath.row].title
      cell.title.text = trackTitle
    default:
      cell.title.text = ""
    }

    return cell
  }
}

extension RecentViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)

    switch indexPath.section {
    case 0:
      self.delegate?.searchHistroySelected(keyword: FirebaseManager.shared.searchHistory[indexPath.row])
    case 1:
      self.delegate?.watchHistorySelected(track: FirebaseManager.shared.watchHistory[indexPath.row])
    default:
      return
    }
  }
}
