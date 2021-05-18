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


}

