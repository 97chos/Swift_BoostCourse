//
//  CollectionViewController.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/13.
//

import Foundation
import SnapKit

class CollectionViewController: UIViewController {

  // MARK: Propterties

  private let singleton = MovieListData.shared

  // MARK: UI

  private let collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    return collectionView
  }()
  private lazy var setSortButton: UIBarButtonItem = {
    let item = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(barButtonItemSelected))
    return item
  }()
  private var collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .vertical
    collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    collectionViewLayout.minimumLineSpacing = 10
    collectionViewLayout.minimumInteritemSpacing = 10
    return collectionViewLayout
  }()


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
  }

  override func viewWillAppear(_ animated: Bool) {
    self.collectionView.reloadData()
    self.navigationItem.title = self.singleton.sort.rawValue
  }


  // MARK: Configuration

  private func configure() {
    self.viewConfigure()
    self.congifureCollectionView()
    self.layout()
  }

  private func viewConfigure() {
    self.view.backgroundColor = .systemBackground
    self.navigationItem.rightBarButtonItem = self.setSortButton
    self.navigationItem.title = self.singleton.sort.rawValue
  }

  private func congifureCollectionView() {
    self.collectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: true)
    self.collectionView.backgroundColor = .systemBackground
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier.reuseCollectionViewCell)
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.collectionView)

    self.collectionView.snp.makeConstraints{
      $0.edges.equalTo(self.view.safeAreaLayoutGuide)
    }

  }


  // MARK: Functions

  @objc private func barButtonItemSelected() {
    let sheet = UIAlertController(title: "정렬 방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
    sheet.addAction(UIAlertAction(title: "예매율", style: .default){ [weak self]_ in
      guard let self = self else { return }
      self.singleton.sort = .reservation
      self.navigationItem.title = self.singleton.sort.rawValue
      self.collectionView.reloadData()
    })
    sheet.addAction(UIAlertAction(title: "큐레이션", style: .default){ [weak self] _ in
      guard let self = self else { return }
      self.singleton.sort = .curation
      self.navigationItem.title = self.singleton.sort.rawValue
      self.collectionView.reloadData()
    })
    sheet.addAction(UIAlertAction(title: "개봉일", style: .default){ [weak self] _ in
      guard let self = self else { return }
      self.singleton.sort = .release
      self.navigationItem.title = self.singleton.sort.rawValue
      self.collectionView.reloadData()
    })
    sheet.addAction(UIAlertAction(title: "취소", style: .cancel))

    self.present(sheet, animated: true)
  }
}


extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.singleton.movieList.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier.reuseCollectionViewCell, for: indexPath) as? CollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.set(movie: self.singleton.movieList[indexPath.row])

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = DetailViewController(viewModel: DetailViewModel(movieId: self.singleton.movieList[indexPath.row].id))
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let inset = self.collectionViewFlowLayout.sectionInset
    let saftyAreaHeight = self.view.safeAreaLayoutGuide.layoutFrame.height

    let itemsPerRow: CGFloat = 2
    let widthPadding = inset.left * (itemsPerRow + 1)

    let itemsPerColumn: CGFloat = 3
    let heightPadding = inset.top * (itemsPerColumn + 1)

    let width: CGFloat = (collectionView.frame.width - widthPadding) / itemsPerRow
    let height: CGFloat = (saftyAreaHeight - heightPadding) / itemsPerColumn

    return CGSize(width: width, height: height)
  }
}
