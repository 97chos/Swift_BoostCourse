//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/14.
//

import Foundation
import UIKit
import SnapKit

class DetailViewController: UIViewController {

  // MARK: Properties

  private let viewModel: DetailViewModel


  // MARK: UI

  private let tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    return tableView
  }()


  // MARK: Initializing

  init(viewModel: DetailViewModel) {
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
    self.layout()
    self.configureTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }


  // MARK: Configuration

  private func configure() {
    self.view.backgroundColor = .systemBackground
    self.title = viewModel.movie.title
  }

  private func configureTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self

    self.tableView.register(MovieInfoCell.self, forCellReuseIdentifier: reuseIdentifier.reuseDetailViewInforCell)
    self.tableView.estimatedSectionHeaderHeight = 80
    self.tableView.rowHeight = UITableView.automaticDimension
  }


  // MARK: Completion

  private func completion(result: Result<(),APIError>) {
    switch result {
    case .success():
      break
    case .failure(.clientError):
      print("클라이언트 에러입니다.")
    case .failure(.parseError):
      print("파싱에러입니다.")
    case .failure(.responseError):
      print("응답에러입니다.")
    case .failure(.urlError):
      print("잘못된 URL입니다.")
    }
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.tableView)

    self.tableView.snp.makeConstraints {
      $0.edges.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier.reuseDetailViewInforCell, for: indexPath) as? MovieInfoCell else {
        return UITableViewCell()
      }
      cell.setData(id: self.viewModel.movie.id, completion: { self.completion(result: $0) })
      return cell
    } else if indexPath.section == 1 {
      let cell = UITableViewCell()
      cell.backgroundColor = .black
      return cell
    } else {
      let cell = UITableViewCell()
      cell.backgroundColor = .blue
      return cell
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 250
    } else {
      return 30
    }
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }
}
