//
//  ViewController.swift
//  SimpleRSSReader
//
//  Created by sangho Cho on 2021/05/10.
//

import UIKit
import SnapKit


class ViewController: UIViewController {

  // MARK: UI

  private let tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()


  // MARK: Properties

  let viewModel: ViewModel


  // MARK: Initializing

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


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
    self.viewModel.parseRSS {
      self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
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
    guard let rssItems = self.viewModel.rssItems else { return 0 }
    return rssItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
      return UITableViewCell()
    }

    if let rssItem = self.viewModel.rssItems?[indexPath.row] {
      cell.set(rss: rssItem)
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    tableView.deselectRow(at: indexPath, animated: true)

    guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell else { return }

    tableView.beginUpdates()
    cell.newsDescriptionLabel.numberOfLines == 4 ? cell.changeLines(cellState: .expanded) : cell.changeLines(cellState: .collapsed)
    self.viewModel.rssItems?[indexPath.row].cellState = cell.newsDescriptionLabel.numberOfLines == 4 ? .expanded : .collapsed
    tableView.endUpdates()
  }

}

