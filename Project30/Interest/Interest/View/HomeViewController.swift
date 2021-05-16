//
//  HomeViewController.swift
//  Interest
//
//  Created by sangho Cho on 2021/05/13.
//

import Foundation
import SnapKit

class HomeViewController: UIViewController {

  // MARK: UI

  private var backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "r1")?.ImageBlur(radius: 20)
    return imageView
  }()
  private var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    collectionView.decelerationRate = .fast
    return collectionView
  }()
  private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    flowLayout.minimumInteritemSpacing = 30
    return flowLayout
  }()


  // MARK: Properties

  private var viewModel: HomeViewModel


  // MARK: Initailizing

  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configuration()
    self.layout()
  }


  // MARK: Configuration

  private func configuration() {
    self.configureCollectionView()
  }

  private func configureCollectionView() {
    self.collectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: true)
    self.collectionView.register(InterestCollcetionViewCell.self, forCellWithReuseIdentifier: "cell")
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.backgroundColor = .none
  }

  private func carousel() {
    let inset = self.collectionViewFlowLayout.sectionInset

    let itemsPerRow: CGFloat = 1.5
    let widthPadding = inset.left * (itemsPerRow + 1)

    self.collectionView.contentInset = UIEdgeInsets(top: 0, left: widthPadding, bottom: 0, right: widthPadding)
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.backgroundImageView)
    self.view.addSubview(self.collectionView)

    self.backgroundImageView.snp.makeConstraints{
      $0.edges.equalToSuperview()
    }

    self.collectionView.snp.makeConstraints{
      $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(50)
      $0.height.equalToSuperview().multipliedBy(0.5)
      $0.width.equalToSuperview()
      $0.leading.equalToSuperview()
    }
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.interests.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? InterestCollcetionViewCell else {
      return UICollectionViewCell()
    }

    cell.set(interest: self.viewModel.interests[indexPath.row])

    return cell
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let inset = self.collectionViewFlowLayout.sectionInset

    let itemsPerRow: CGFloat = 1.5
    let widthPadding = inset.left * (itemsPerRow + 1)

    let width: CGFloat = (collectionView.frame.width - widthPadding) / itemsPerRow

    return CGSize(width: width, height: collectionView.frame.height)
  }
}
