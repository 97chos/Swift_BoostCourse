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


  // MARK: Properties

  private var cityList: [City] = []

  // MARK: UI

  private let tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    return tableView
  }()


  // MARK: Initilaize

  init(cityCode: String) {
    super.init(nibName: nil, bundle: nil)
    self.decodeJsonData(cityCode)
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

}
