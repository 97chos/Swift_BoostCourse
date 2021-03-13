//
//  ViewController.swift
//  MyAlbum
//
//  Created by sangho Cho on 2021/02/18.
//

import Foundation
import UIKit
import Photos

enum ReusealbleIdentifier{
  static let albumViewCell = "albumViewCell"
  static let imagesViewCell = "imagesViewCell"
}

class AlbumViewController: UIViewController {

  // MARK: Properties

  private var resultAssetCollection: PHFetchResult<PHAssetCollection>?
  private let imageManager = PHCachingImageManager()


  // MARK: UI

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    collectionView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    collectionView.backgroundColor = .systemBackground
    collectionView.alwaysBounceVertical = true
    return collectionView
  }()
  private let collectionViewLayout: UICollectionViewFlowLayout = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .vertical
    collectionViewLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    collectionViewLayout.minimumLineSpacing = 10
    collectionViewLayout.minimumInteritemSpacing = 10
    return collectionViewLayout
  }()


  // MARK: View LifeCycle

  override func viewDidLoad() {
    self.checkAuthorization()
    self.configure()
    self.layout()
    PHPhotoLibrary.shared().register(self)
  }

  // MARK: Configuration

  private func configure() {
    self.viewConfigure()
  }

  private func viewConfigure() {
    self.title = "앨범"
    self.view.backgroundColor = .systemBackground
    self.navigationController?.navigationBar.prefersLargeTitles = true

    self.collectionView.delegate = self
    self.collectionView.dataSource = self

    self.collectionView.setCollectionViewLayout(self.collectionViewLayout, animated: true)
    self.collectionView.register(AlbumCollectionViewItem.self, forCellWithReuseIdentifier: ReusealbleIdentifier.albumViewCell)
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.collectionView)

    self.collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }


  // MARK: Functions

  private func checkAuthorization() {
    let isAuthorized = PHPhotoLibrary.authorizationStatus()

    switch isAuthorized {
    case .authorized:
      self.fetchAssetCollection()
      DispatchQueue.main.async {
        self.collectionView.reloadSections(IndexSet(arrayLiteral: 0))
      }
    case .denied:
      print("접근 거부")
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization{ status in
        switch status {
        case .authorized:
          self.fetchAssetCollection()
          DispatchQueue.main.async {
            self.collectionView.reloadData()
          }
        case .denied:
          print("거부됨")
        default:
          print("그외")
        }
      }
    case .limited:
      print("제한된 접근")

    case .restricted:
      print("접근 제한")

    @unknown default:
      print("미래를 위한 에러 처리")
    }
  }


  // MARK: Fetch Assets

  private func fetchAssetCollection() {
    let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album,
                                                                                               subtype: .any,
                                                                                               options: nil)
    self.resultAssetCollection = cameraRoll
  }

  private func fetchAsset(AssetCollection: PHAssetCollection) -> PHAsset {
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

    let resultAsset = PHAsset.fetchAssets(in: AssetCollection, options: fetchOptions).lastObject ?? PHAsset()

    return resultAsset
  }
}


// MARK: CollectionView DataSource

extension AlbumViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.resultAssetCollection?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: ReusealbleIdentifier.albumViewCell, for: indexPath) as? AlbumCollectionViewItem else {
      return UICollectionViewCell()
    }

    guard let assetCollection = self.resultAssetCollection?[indexPath.item] else {
      return UICollectionViewCell()
    }

    let collectionTitle: String = assetCollection.localizedTitle ?? ""
    let collectionCount: Int = assetCollection.estimatedAssetCount
    let asset = self.fetchAsset(AssetCollection: assetCollection)

    guard collectionCount != 0 else {
      item.set(image: UIImage(named: "empty")!, title: collectionTitle, count: 0)
      return item
    }

    imageManager.requestImage(for: asset,
                              targetSize: CGSize(width: 20, height: 20),
                              contentMode: .aspectFill,
                              options: nil,
                              resultHandler: { image, _ in
                                guard let image = image else {
                                  return
                                }
                                item.set(image: image, title: collectionTitle, count: collectionCount)
                              })
    return item
  }
}


// MARK: CollectionView Delegate

extension AlbumViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let imagesViewController = ImagesViewController(asset: self.resultAssetCollection?[indexPath.item] ?? PHAssetCollection())
    self.navigationController?.pushViewController(imagesViewController, animated: true)
  }
}


// MARK: CollectionView Delegate Flow Layout

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let inset = self.collectionViewLayout.sectionInset
    let saftyAreaHeight: CGFloat = self.view.safeAreaLayoutGuide.layoutFrame.height

    let itemsPerRow: CGFloat = 2
    let widthPadding = inset.left * (itemsPerRow + 1)
    let itemsPerColumn: CGFloat = 3
    let heightPadding = inset.top * (itemsPerColumn + 1)
    let width: CGFloat = (self.collectionView.frame.width - widthPadding) / itemsPerRow
    let height: CGFloat = (saftyAreaHeight - heightPadding) / itemsPerColumn

    return CGSize(width: width, height: height)
  }
}


extension AlbumViewController: PHPhotoLibraryChangeObserver {
  func photoLibraryDidChange(_ changeInstance: PHChange) {
    guard let resultAssertCollection = self.resultAssetCollection,
          let change = changeInstance.changeDetails(for: resultAssertCollection) else {
      return
    }

    self.resultAssetCollection = change.fetchResultAfterChanges

    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
}
