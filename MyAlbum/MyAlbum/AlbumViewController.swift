//
//  ViewController.swift
//  MyAlbum
//
//  Created by sangho Cho on 2021/02/18.
//

import UIKit
import SnapKit

class AlbumViewController: UIViewController {

  // MARK: Properties

  private let dummy:[String] = ["roll","favorite","음식","사람들","여행"]


  // MARK: UI

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView()
    collectionView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    collectionView.backgroundColor = .systemBackground
    return collectionView
  }()
  private let collectionViewLayout: UICollectionViewFlowLayout = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .vertical
    collectionViewLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    return collectionViewLayout
  }()


  // MARK: View LifeCycle
  override func viewDidLoad() {
    self.configure()
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
  }


}

extension AlbumViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.dummy.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    <#code#>
  }


}

extension AlbumViewController: UICollectionViewDelegate {

}
