//
//  ViewController.swift
//  SimpleRSSReader
//
//  Created by sangho Cho on 2021/05/10.
//

import UIKit
import SnapKit

enum CellState {
  case expanded
  case collapsed
}

class ViewController: UIViewController {

  // MARK: UI

  private let tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()


  // MARK: Properties

  private let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
  private let feedParser = RSSParser()
  private var cellStates: [CellState]?
  private var rssItems: [RSSItem]?


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.configuration()
    self.parseRSS()
    self.layout()
  }


  // MARK: Configuration

  private func configuration() {
    self.configureView()
    self.configureTableView()
  }

  private func configureView() {
    self.view.backgroundColor = .systemBackground
  }

  private func configureTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self

    self.tableView.estimatedRowHeight = 140
    self.tableView.rowHeight = UITableView.automaticDimension

    self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
  }


  // MARK: Parse RSS

  private func parseRSS() {
    self.feedParser.parseFeed(feedURL: self.feedURL) { [weak self] rssItems in
      guard let self = self else { return }
      self.rssItems = rssItems
      self.cellStates = Array(repeating: .collapsed, count: rssItems.count)

      DispatchQueue.main.async {
        self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
      }
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let rssItems = rssItems else { return 0 }
    return rssItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
      return UITableViewCell()
    }

    if let rssItem = self.rssItems?[indexPath.row] {
      cell.set(rss: rssItem)

      if let cellState = cellStates?[indexPath.row] {
        cell.changeLines(cellState: cellState)
      }
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    tableView.deselectRow(at: indexPath, animated: true)

    guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell else { return }

    tableView.beginUpdates()
    cell.newsDescriptionLabel.numberOfLines == 4 ? cell.changeLines(cellState: .expanded) : cell.changeLines(cellState: .collapsed)
    self.cellStates?[indexPath.row] = cell.newsDescriptionLabel.numberOfLines == 4 ? .expanded : .collapsed
    tableView.endUpdates()
  }

}

