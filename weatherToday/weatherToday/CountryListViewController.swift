//
//  CountryListViewController.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation
import SnapKit

class CountryListViewController: UIViewController {

  // MARK: Constants

  private enum ReuseIdentifier {
    static let countryCell = "countryCell"
  }


  // MARK: Properties

  private var countriesList: [country] = []

  // MARK: UI

  private let tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    return tableView
  }()


  // MARK: View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
    self.decodeJson()
  }


  // MARK: Layout

  private func configure() {
    self.viewConfigure()
    self.tableViewConfigure()
    self.layout()
  }

  private func viewConfigure() {
    self.title = "세계 날씨"
    self.view.backgroundColor = .systemBackground
  }

  private func tableViewConfigure() {
    self.tableView.register(CountryCell.self, forCellReuseIdentifier: ReuseIdentifier.countryCell)
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.tableFooterView = UIView()
  }

  private func layout() {
    self.view.addSubview(tableView)

    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }


  // MARK: JsonDecode

  func decodeJson() {
    let decoder = JSONDecoder()
    guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
      return
    }

    do {
      self.countriesList = try decoder.decode([country].self, from: dataAsset.data)
    } catch {
      print(error.localizedDescription)
    }
  }
}

extension CountryListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.countriesList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.countryCell, for: indexPath) as? CountryCell else {
      return UITableViewCell()
    }

    cell.set(country: self.countriesList[indexPath.row])

    return cell
  }
}

extension CountryListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
  }
}
