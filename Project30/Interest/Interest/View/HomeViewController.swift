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
    collectionView.bounces = false
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()
  private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let flowLayout = CarouselLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = -30
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

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let inset = self.collectionView.contentInset

    let itemsPerRow: CGFloat = 1.5
    let widthPadding = inset.left * (itemsPerRow + 1)

    let width: CGFloat = (collectionView.frame.width - widthPadding) / itemsPerRow
    let sectionSideInset = collectionView.frame.width / 2 - width / 2

    self.collectionViewFlowLayout.sectionInset.left = sectionSideInset
    self.collectionViewFlowLayout.sectionInset.right = sectionSideInset

    return CGSize(width: width, height: collectionView.frame.height)
  }


  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let inset = self.collectionView.contentInset

    let itemsPerRow: CGFloat = 1.5
    let widthPadding = inset.left * (itemsPerRow + 1)

    // cell의 넓이
    let cellWidth: CGFloat = (collectionView.frame.width - widthPadding) / itemsPerRow

    // spacing을 포함한 cell의 넓이 (스크롤 시 움직일 거리)
    let cellWidthIncludeSpacing = cellWidth + self.collectionViewFlowLayout.minimumLineSpacing

    // 스크롤이 끝났을 때 예상되는 움직인 거리
    var offset = targetContentOffset.pointee
    // 움직임이 끝난 후의 cell 인덱스 = 움직인 거리 + cell Spacing / spacing을 포함한 cell의 넓이
    let index = (offset.x + scrollView.contentInset.right) / cellWidthIncludeSpacing
    let roundedIndex: CGFloat = round(index)

    // content가 위치할 x좌표 = cell의 spacing을 포함한 넓이 * cell의 인덱스
    offset = CGPoint(x: cellWidthIncludeSpacing * roundedIndex  - scrollView.contentInset.left, y: scrollView.contentInset.top)
    targetContentOffset.pointee = offset
  }
}
