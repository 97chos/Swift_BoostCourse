//
//  ViewController.swift
//  CandySearch
//
//  Created by sangho Cho on 2021/05/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  // MARK: UI

  private let tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()
  private let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
    searchController.obscuresBackgroundDuringPresentation = true
    searchController.searchBar.showsScopeBar = true
    searchController.searchBar.placeholder = "Search Candy"
    return searchController
  }()


  // MARK: Properties

  private var viewModel: SearchViewModel


  // MARK: Initializing

  init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewConfiguration()
  }


  // MARK: Configuration

  private func viewConfiguration() {
    self.configureView()
    self.configureTableView()
    self.configutaionSearchController()
    self.layout()
  }

  private func configureView() {
    self.view.backgroundColor = .systemBackground
  }

  private func configureTableView() {
    self.tableView.register(CandyCell.self, forCellReuseIdentifier: "candyCell")
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

  private func configutaionSearchController() {
    self.searchController.searchBar.delegate = self
    self.searchController.searchResultsUpdater = self
    self.navigationItem.searchController = self.searchController
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.tableView)

    self.tableView.snp.makeConstraints{
      $0.edges.equalTo(self.view.safeAreaInsets)
    }
  }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.filteredCandies.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "candyCell", for: indexPath) as? CandyCell else {
      return UITableViewCell(style: .subtitle, reuseIdentifier: "candyCell")
    }

    cell.set(candy: self.viewModel.filteredCandies[indexPath.row])

    return cell
  }


}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating  {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    guard let scopeList = searchBar.scopeButtonTitles else { return }

    self.viewModel.filterContent(searchBar.text, scopeList[searchBar.selectedScopeButtonIndex])
    self.tableView.reloadData()
  }

  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    self.viewModel.filterContent(searchBar.text, searchBar.scopeButtonTitles![selectedScope])
  }
}
