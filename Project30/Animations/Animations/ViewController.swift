//
//  ListViewController.swift
//  Animations
//
//  Created by sangho Cho on 2021/05/18.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {

  // MARK: UI

  private let tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()


  // MARK: Properties

  private let items: [AnimationType] = AnimationType.allCases


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configuration()
    self.layout()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.animateTableView()
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
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }


  // MARK: Load TableView Animation

  private func animateTableView() {
    self.tableView.reloadData()

    let cells = self.tableView.visibleCells
    let tableHeight = self.tableView.bounds.size.height

    for cell in cells {
      cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
    }

    var index = 0
    for cell in cells {
      UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: [], animations: {
        cell.transform = CGAffineTransform(translationX: 0, y: 0)
      }, completion: nil)
      index += 1
    }
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.tableView)

    self.tableView.snp.makeConstraints{
      $0.edges.equalTo(self.view.safeAreaLayoutGuide)
    }
  }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
      return UITableViewCell()
    }

    cell.textLabel?.text = self.items[indexPath.row].rawValue

    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Basic Animations"
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailVC = DetailViewController(animateType: self.items[indexPath.row])
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
}


