//
//  ViewController.swift
//  CandySearch
//
//  Created by sangho Cho on 2021/05/01.
//

import UIKit

class ViewController: UIViewController {

  // MARK: UI

  let tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()
  let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
    searchController.obscuresBackgroundDuringPresentation = true
    return searchController
  }()


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

