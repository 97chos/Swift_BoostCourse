//
//  ListViewController.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/13.
//

import UIKit
import SnapKit

enum reuseIdentifier {
  static let reuseCell = "ReusableCell"
}

class ListViewController: UIViewController {

  // MARK: Properties

  let viewModel: ListViewModel


  // MARK: UI

  private let tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()
  private lazy var setSortButton: UIBarButtonItem = {
    let item = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(barButtonItemSelected))
    return item
  }()


  // MARK: Initializing

  init(viewModel: ListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
    self.loadMoviewData()
  }


  // MARK: Configuration

  private func configure() {
    self.layout()
    self.viewConfigure()
    self.tableViewConfigure()
  }

  private func viewConfigure() {
    self.view.backgroundColor = .systemBackground
    self.navigationItem.rightBarButtonItem = self.setSortButton
    self.title = viewModel.sort.rawValue
  }

  private func tableViewConfigure() {
    self.tableView.register(ListViewCell.self, forCellReuseIdentifier: reuseIdentifier.reuseCell)
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }

  private func loadMoviewData() {
    self.viewModel.loadMovies{ result in
      switch result {
      case .success(let movies):
        self.viewModel.movieList = movies
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        let errorType = error as? APIError
        print((errorType?.description)!)
      }
    }
  }


  // MARK: Functions

  @objc private func barButtonItemSelected() {
    let sheet = UIAlertController(title: "정렬 방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
    sheet.addAction(UIAlertAction(title: "예매율", style: .default){ [weak self]_ in
      guard let self = self else { return }
      self.viewModel.sort = .reservation
      self.title = self.viewModel.sort.rawValue
      self.tableView.reloadData()
    })
    sheet.addAction(UIAlertAction(title: "큐레이션", style: .default){ [weak self] _ in
      guard let self = self else { return }
      self.viewModel.sort = .curation
      self.title = self.viewModel.sort.rawValue
      self.tableView.reloadData()
    })
    sheet.addAction(UIAlertAction(title: "개봉일", style: .default){ [weak self] _ in
      guard let self = self else { return }
      self.viewModel.sort = .release
      self.title = self.viewModel.sort.rawValue
      self.tableView.reloadData()
    })
    sheet.addAction(UIAlertAction(title: "취소", style: .cancel))

    self.present(sheet, animated: true)
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.tableView)

    self.tableView.snp.makeConstraints{
      $0.edges.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.movieList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier.reuseCell) as? ListViewCell else {
      return UITableViewCell()
    }

    cell.set(movie: self.viewModel.movieList[indexPath.row])

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

