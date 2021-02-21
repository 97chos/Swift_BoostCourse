//
//  ImagesViewController.swift
//  MyAlbum
//
//  Created by sangho Cho on 2021/02/20.
//

import Foundation
import UIKit
import Photos
import SnapKit

class ImagesViewController: UIViewController {


  // MARK: Properties

  private let assets: PHAssetCollection!
  private var fetchResult: PHFetchResult<PHAsset>?
  private let imageManager: PHCachingImageManager = PHCachingImageManager()
  private var descend: Bool = false {
    didSet {
      if descend {
        self.alignButton.title = "오래된순"
      } else {
        self.alignButton.title = "최신순"
      }
    }
  }


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
  private let toolBar: UIToolbar = {
    let toolBar = UIToolbar(frame: CGRect.zero)
    toolBar.barTintColor = .systemGray
    return toolBar
  }()
  private lazy var alignButton: UIBarButtonItem = {
    let barbutton = UIBarButtonItem(title: "최신순", style: .plain, target: self, action: #selector(self.chageAlign))
    return barbutton
  }()
  private let flexibleSpace1: UIBarButtonItem = {
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    return flexibleSpace
  }()
  private let flexibleSpace2: UIBarButtonItem = {
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    return flexibleSpace
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


  // MARK: Actions

  @objc private func chageAlign() {
    self.descend = !descend
    self.fetchFromAssetCollection(descend: descend)
    self.collectionView.reloadData()
  }


  // MARK: Configuration

  private func configure() {
    self.viewConfigure()
    self.fetchFromAssetCollection()
    self.layout()
  }

  private func viewConfigure() {
    self.title = self.assets.localizedTitle
    self.view.backgroundColor = .systemBackground
    self.navigationItem.largeTitleDisplayMode = .never

    self.collectionView.delegate = self
    self.collectionView.dataSource = self

    self.collectionView.setCollectionViewLayout(self.collectionViewFlowLayout, animated: true)
    self.collectionView.register(ImagesViewItem.self, forCellWithReuseIdentifier: ReusealbleIdentifier.imagesViewCell)
  }

  private func fetchFromAssetCollection(descend: Bool = false) {
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: descend)]

    self.fetchResult = PHAsset.fetchAssets(in: self.assets, options: fetchOptions)
  }

  private func layout() {
    self.view.addSubview(self.collectionView)
    self.view.addSubview(toolBar)

    self.toolBar.snp.makeConstraints{
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      $0.width.equalToSuperview()
      $0.leading.equalToSuperview()
    }

    self.toolBar.setItems([flexibleSpace1,alignButton,flexibleSpace2], animated: true)
  }

}

extension ImagesViewController: UICollectionViewDelegate {

}

extension ImagesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.fetchResult?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: ReusealbleIdentifier.imagesViewCell, for: indexPath) as? ImagesViewItem else { return UICollectionViewCell() }

    let asset = self.fetchResult?.object(at: indexPath.item) ?? PHAsset()

    self.imageManager.requestImage(for: asset,
                                   targetSize: CGSize(width: 10, height: 10),
                                   contentMode: .aspectFill,
                                   options: nil,
                                   resultHandler: { image, _ in
                                    guard let image = image else {
                                      return
                                    }
                                    item.set(image: image)
                                   })

    return item
  }
}

extension ImagesViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let inset = self.collectionViewFlowLayout.sectionInset

    let itemPerRow: CGFloat = 3
    let widthPadding = inset.left * (itemPerRow + 1)

    let widthAndHeight: CGFloat = (self.collectionView.frame.width - widthPadding) / itemPerRow

    return CGSize(width: widthAndHeight, height: widthAndHeight)
  }
}

