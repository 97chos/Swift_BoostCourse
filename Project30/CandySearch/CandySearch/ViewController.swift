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
  private let navigationTitleView: UIView = {
    let view = UIImageView()
    view.image = UIImage(named: "Inline-Logo")
    view.contentMode = .scaleAspectFit
    return view
  }()
  let statusBar: UIView = {
    return UIView()
  }()


  // MARK: Properties

  private var viewModel: SearchViewModel
  private lazy var statusFrame = self.view.window?.windowScene?.statusBarManager?.statusBarFrame


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

  override func viewDidLayoutSubviews() {
    self.setColorStatusBar(color: .systemGreen)
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
    self.navigationItem.titleView = self.navigationTitleView
    self.navigationController?.navigationBar.backgroundColor = .systemGreen
  }

  private func configureTableView() {
    self.tableView.register(CandyCell.self, forCellReuseIdentifier: "candyCell")
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

  private func configutaionSearchController() {
    self.searchController.searchBar.delegate = self
    self.searchController.searchResultsUpdater = self
    definesPresentationContext = true
    self.navigationItem.searchController = self.searchController
  }

  private func setColorStatusBar(color: UIColor) {
    guard let frame = self.statusFrame else { return }
    self.statusBar.frame = frame
    self.statusBar.backgroundColor = color
    self.view.addSubview(self.statusBar)
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.tableView)

    self.tableView.snp.makeConstraints{
      $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
      $0.bottom.equalToSuperview()
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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    let detailViewController = DetailViewController(candy: self.viewModel.filteredCandies[indexPath.row])
    self.navigationController?.pushViewController(detailViewController, animated: true)
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
