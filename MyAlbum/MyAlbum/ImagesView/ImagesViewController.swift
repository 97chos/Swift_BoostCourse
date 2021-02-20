//
//  ImagesViewController.swift
//  MyAlbum
//
//  Created by sangho Cho on 2021/02/20.
//

import Foundation
import UIKit
import Photos

class ImagesViewController: UIViewController {


  // MARK: Properties

  private let assets: PHAssetCollection!
  private let fetchResult: PHFetchResult<PHAsset>?


  // MARK: UI

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    collectionView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    collectionView.backgroundColor = .systemBackground
    collectionView.alwaysBounceVertical = true
    return collectionView
  }()
  private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    flowLayout.minimumLineSpacing = 10
    flowLayout.minimumInteritemSpacing = 10
    return flowLayout
  }()


  init(asset: PHAssetCollection) {
    self.assets = asset
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
  }


  // MARK: Configuration

  private func configure() {
    self.viewConfigure()
  }

  private func viewConfigure() {
    self.title = self.assets.localizedTitle
    self.view.backgroundColor = .systemBackground

    self.collectionView.delegate = self
    self.collectionView.dataSource = self
  }

}

extension ImagesViewController: UICollectionViewDelegate {

}

extension ImagesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.assets.estimatedAssetCount
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    <#code#>
  }


}

