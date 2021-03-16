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
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }


  // MARK: Configuration

  private func configure() {
    self.configureView()
    self.configureTableView()
  }

  private func configureView() {
    self.view.backgroundColor = .systemBackground
    self.title = viewModel.movie.first?.title
    self.viewModel.delegate = self
  }

  private func configureTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self

    self.tableView.register(MovieInfoCell.self, forCellReuseIdentifier: reuseIdentifier.reuseDetailViewInforCell)
    self.tableView.register(MovieSynopsisCell.self, forCellReuseIdentifier: reuseIdentifier.reuseDetailViewsynopsisCell)
    self.tableView.register(MovieCrewCell.self, forCellReuseIdentifier: reuseIdentifier.reuseDetailViewCrewCell)
    self.tableView.estimatedSectionHeaderHeight = 80
    self.tableView.estimatedRowHeight = 200
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
    return viewModel.sectionList.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0,1,2:
      return viewModel.movie.count
    case 3:
      return viewModel.moviewReviews.count+1
    default:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    switch indexPath.section {
    case 0:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier.reuseDetailViewInforCell, for: indexPath) as? MovieInfoCell else {
        return UITableViewCell()
      }
      guard let movie = self.viewModel.movie.first else {
        return UITableViewCell()
      }
      cell.set(movie: movie)
      return cell
    case 1:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier.reuseDetailViewsynopsisCell, for: indexPath) as? MovieSynopsisCell else {
        return UITableViewCell()
      }
      guard let movie = self.viewModel.movie.first else {
        return UITableViewCell()
      }
      cell.set(movie: movie)
      return cell
    case 2:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier.reuseDetailViewCrewCell, for: indexPath) as? MovieCrewCell else {
        return UITableViewCell()
      }
      guard let movie = self.viewModel.movie.first else {
        return UITableViewCell()
      }
      cell.set(movie: movie)
      return cell
    default:
      return UITableViewCell()
    }
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }
}


extension DetailViewController: layoutUpdateDelegate {
  func layoutReload() {
    self.tableView.reloadData()
    self.title = viewModel.movie.first?.title
  }
}
