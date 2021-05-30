//
//  ViewController.swift
//  Vibe_CloneUI
//
//  Created by sangho Cho on 2021/05/28.
//
import UIKit

class ViewController: UIViewController {

    // MARK: UI

    @IBOutlet weak var collectionView: UICollectionView!


    // MARK: Properties

    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
    let colors: [UIColor] = [.systemRed,.systemPink,.systemPurple,.systemIndigo,.systemBlue]


    // MARK: View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
    }


    // MARK: Configuration

    func configureCollectionView() {
        self.collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "headerView")

        self.collectionView.collectionViewLayout = self.createLayout()
    }


    // MARK: Groups

    func firstGroup() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 15, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: self.headerSize, elementKind: "header", alignment: .topLeading)
        section.boundarySupplementaryItems = [header]

        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        return section
    }

    func secondGroup() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: self.headerSize, elementKind: "header", alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        return section
    }

    func thirdGroup() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)

        let section = NSCollectionLayoutSection(group: group)

        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: self.headerSize, elementKind: "header", alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        return section
    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            print(sectionNumber)
            if sectionNumber == 0 {
                return self.firstGroup()
            } else if sectionNumber == 1 {
                return self.secondGroup()
            } else {
                return self.thirdGroup()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(section)
        if section == 2 {
            return 15
        } else {
            return 5
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item % colors.count]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? CollectionHeaderView else {
            return .init()
        }
        view.set(title: "곡 순위")

        return view
    }

}
