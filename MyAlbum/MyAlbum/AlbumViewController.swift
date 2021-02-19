//
//  ViewController.swift
//  MyAlbum
//
//  Created by sangho Cho on 2021/02/18.
//

import Foundation
import UIKit
import SnapKit

enum ReusealbleIdentifier{
  static let collectionViewCell = "CollectionViewCell"
}

class AlbumViewController: UIViewController {

  // MARK: Properties

  private let dummy:[String] = ["roll","favorite","음식","사람들","여행"]


  // MARK: UI

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    collectionView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    collectionView.backgroundColor = .systemGray
    return collectionView
  }()
  private let collectionViewLayout: UICollectionViewFlowLayout = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .vertical
    collectionViewLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    collectionViewLayout.minimumLineSpacing = 80
    return collectionViewLayout
  }()


  // MARK: View LifeCycle
  override func viewDidLoad() {
    self.configure()
    self.layout()
  }


  // MARK: Configuration

  private func configure() {
    self.viewConfigure()
  }

  private func viewConfigure() {
    self.title = "MyAlbum"
    self.view.backgroundColor = .systemBackground

    self.collectionView.delegate = self
    self.collectionView.dataSource = self

    self.collectionView.setCollectionViewLayout(self.collectionViewLayout, animated: true)
    self.collectionView.register(AlbumCollectionViewItem.self, forCellWithReuseIdentifier: ReusealbleIdentifier.collectionViewCell)
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.collectionView)

    self.collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

}

extension AlbumViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.dummy.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: ReusealbleIdentifier.collectionViewCell, for: indexPath) as? AlbumCollectionViewItem else {
      return UICollectionViewCell()
    }

    return item
  }


}

extension AlbumViewController: UICollectionViewDelegate {

}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let width: CGFloat = (self.collectionView.frame.width - 50) / 2
    let height: CGFloat = width + 30

    return CGSize(width: width, height: height)
  }
}
