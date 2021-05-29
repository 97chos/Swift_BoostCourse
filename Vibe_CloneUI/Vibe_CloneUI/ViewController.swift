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

    let size = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .fractionalHeight(0.2))
    lazy var item = NSCollectionLayoutItem(layoutSize: size)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
    lazy var group = NSCollectionLayoutGroup.horizontal(layoutSize: self.groupSize, subitem: self.item, count: 4)

    lazy var section = NSCollectionLayoutSection(group: self.group)
    lazy var layout = UICollectionViewCompositionalLayout(section: self.section)

    let colors: [UIColor] = [.systemRed,.systemPink,.systemPurple,.systemIndigo,.systemBlue]


    // MARK: View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = self.layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item % colors.count]

        return cell
    }
}
