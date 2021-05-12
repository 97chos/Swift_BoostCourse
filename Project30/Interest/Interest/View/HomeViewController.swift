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
    return collectionView
  }()
  private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    flowLayout.minimumLineSpacing = 10
    flowLayout.minimumInteritemSpacing = 10
    return flowLayout
  }()


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
  }


  // MARK: Layout

  private func layout() {
    self.view = self.backgroundImageView
    self.view.addSubview(self.collectionView)

    self.collectionView.snp.makeConstraints{
      $0.edges.equalTo(self.view.safeAreaLayoutGuide)
    }

  }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    <#code#>
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    <#code#>
  }
}
