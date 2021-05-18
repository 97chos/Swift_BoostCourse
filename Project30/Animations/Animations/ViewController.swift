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
    // Do any additional setup after loading the view.
  }


}

