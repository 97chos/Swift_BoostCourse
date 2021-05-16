//
//  CarouselLayout.swift
//  Interest
//
//  Created by sangho Cho on 2021/05/16.
//

import Foundation
import UIKit

class CarouselLayout: UICollectionViewFlowLayout {

  var sideItemScale: CGFloat = 0.5
  var sideItemAlpha: CGFloat = 0.5
  var spacing: CGFloat = 20

  var isPagingEnabled: Bool = false

  var isSetup: Bool = false

  // collectionView 처음 호출 시, shouldInvalidateLayout 메소드의 리턴 값에 따라 매번 스크롤 시마다 호출되는 메소드
  override func prepare() {
    super.prepare()

    if self.isSetup == false {
      self.setupLayout()
      self.isSetup = true
    }
  }

  private func setupLayout() {
    guard let collectionView = self.collectionView else { return }

    let collectionViewSize = collectionView.bounds.size

    // collectionView 내 section 간의 inset 설정
    let xInset = (collectionViewSize.width - self.itemSize.width) / 2
    let yInset = (collectionViewSize.height - self.itemSize.height) / 2

    self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)

    let itemWidth = self.itemSize.width

    let scaledItemOffset = (itemWidth - itemWidth * self.sideItemScale) / 2
    self.minimumLineSpacing = self.spacing - scaledItemOffset

    self.scrollDirection = .horizontal
  }

  // 매 스크롤 시마다 레이아웃 변화가 필요할 경우 true를 반환
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }

  // 모든 셀과 뷰에 대한 레이아웃 속성을 UICollectionViewLayoutAttributes 배열로 반환
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let superAttributes = super.layoutAttributesForElements(in: rect),
          // copyItems = 값을 복사하는 것이 아닌 메모리 주소를 복사
          let arrtibutes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else {
      return nil
    }

    return arrtibutes.map{ self.transformLayoutAttributes(attributes: $0) }
  }

  private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    guard let collectionView = self.collectionView else { return attributes }

    let collectionCenter = collectionView.frame.size.width / 2
    // contentOffset = collectionView와 내부 content 사이의 떨어진 거리
    let contentOffset = collectionView.contentOffset.x
    let center = attributes.center.x - contentOffset

    let maxDistance = self.itemSize.width + self.minimumLineSpacing
    let distance = min(abs(collectionCenter - center), maxDistance)

    let ratio = (maxDistance - distance) / maxDistance

    let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
    let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale

    attributes.alpha = alpha

    let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    let dist = attributes.frame.midX - visibleRect.midX
    var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)

    transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
    attributes.transform3D = transform

    return attributes
  }
}
