//
//  ListViewController.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/13.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {

  // MARK: Properties

  let viewModel: ListViewModel
  let singleton = MovieListData.shared


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

  override func viewWillAppear(_ animated: Bool) {
    self.tableView.reloadData()
    self.navigationItem.title = self.singleton.sort.rawValue
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
    self.navigationItem.title = self.singleton.sort.rawValue
  }

  private func tableViewConfigure() {
    self.tableView.register(ListViewCell.self, forCellReuseIdentifier: reuseIdentifier.reuseTableViewCell)
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }

  private func loadMoviewData() {
    self.viewModel.loadMovies{ result in
      switch result {
      case .success(let movies):
        self.singleton.movieList = movies
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
      self.singleton.sort = .reservation
      self.navigationItem.title = self.singleton.sort.rawValue
      self.tableView.reloadData()
    })
    sheet.addAction(UIAlertAction(title: "큐레이션", style: .default){ [weak self] _ in
      guard let self = self else { return }
      self.singleton.sort = .curation
      self.navigationItem.title = self.singleton.sort.rawValue
      self.tableView.reloadData()
    })
    sheet.addAction(UIAlertAction(title: "개봉일", style: .default){ [weak self] _ in
      guard let self = self else { return }
      self.singleton.sort = .release
      self.navigationItem.title = self.singleton.sort.rawValue
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
    return self.singleton.movieList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier.reuseTableViewCell) as? ListViewCell else {
      return UITableViewCell()
    }

    cell.set(movie: self.singleton.movieList[indexPath.row])

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController(viewModel: DetailViewModel(movieId: self.singleton.movieList[indexPath.row].id))
    self.navigationController?.pushViewController(vc, animated: true)

    tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
  }
}

