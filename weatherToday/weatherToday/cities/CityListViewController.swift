//
//  CityListViewController.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation
import UIKit
import SnapKit

class CityListViewController: UIViewController {

  // MARK: Constants

  private enum ReuseIdentifier {
    static let cityCell = "cityCell"
  }


  // MARK: Properties

  private var cityList: [City] = []
  private var country: String!

  // MARK: UI

  private let tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    return tableView
  }()


  // MARK: Initilaizing

  init(cityCode: String, country: String) {
    super.init(nibName: nil, bundle: nil)
    self.decodeJsonData(cityCode)
    self.country = country
  }


  // MARK: View Lifecycle

  override func viewDidLoad() {
    self.configure()
    self.layout()
  }


  // MARK: Configuration

  private func configure() {
    self.viewConfigure()
    self.tableViewConfigure()
  }

  private func viewConfigure() {
    self.title = self.country
    self.view.backgroundColor = .systemBackground
  }

  private func tableViewConfigure() {
    self.tableView.register(CityCell.self, forCellReuseIdentifier: ReuseIdentifier.cityCell)
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.tableFooterView = UIView()
  }


  // MARK: Functions

  private func decodeJsonData(_ cityCode: String) {
    guard let dataAsset: NSDataAsset = NSDataAsset(name: "\(cityCode)") else {
      return
    }

    let decoder = JSONDecoder()
    do {
      self.cityList = try decoder.decode([City].self, from: dataAsset.data)
    } catch {
      print(error.localizedDescription)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Layout

  private func layout() {

    self.view.addSubview(tableView)

    self.tableView.snp.makeConstraints{
      $0.edges.equalToSuperview()
    }
  }
}

extension CityListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cityList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.cityCell, for: indexPath) as? CityCell else {
      return UITableViewCell()
    }

    cell.set(city: self.cityList[indexPath.row])

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.view.frame.height / 8
  }
}

extension CityListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailViewController = WhetherDetailViewController(city: self.cityList[indexPath.row])
    self.navigationController?.pushViewController(detailViewController, animated: true)
    tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
  }

}


