//
//  ViewController.swift
//  MusicChart
//
//  Created by sangho Cho on 2020/12/17.
//

import UIKit

class ViewController: UIViewController {

    var tv = UITableView()
    var cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()

    var nameList = ["brook","chopper","franky","luffy","nami","robin","sanji","zoro"]
    var bountyList = ["3300000","50","4400000","3000000000","16000000","8000000","7000000","120000000"]
    var dataList = [pageData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        layout.scrollDirection = .vertical
        self.cv.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.cv.setCollectionViewLayout(layout, animated: true)
        self.cv.backgroundColor = .clear

        self.view.addSubview(cv)
        cv.dataSource = self
        cv.delegate = self
        cv.register(CustomItem.self, forCellWithReuseIdentifier: "Item")

        // self.tv = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        // self.view.addSubview(tv)
        // tv.dataSource = self
        // tv.delegate = self
        // tv.register(CustomCell.self, forCellReuseIdentifier: "cell")
    }

    func CollectionItemUI(cell: CustomItem, name: String, bounty: String) {
        cell.name.text = name
        cell.bounty.text = bounty
        cell.imgView.image = UIImage(named: "\(name).jpg")

        var data = pageData()
        data.bounty = bounty
        data.img = UIImage(named: "\(name).jpg")
        data.name = name

        dataList.append(data)
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nameList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as? CustomItem ?? UICollectionViewCell()

        self.CollectionItemUI(cell: cell as! CustomItem, name: nameList[indexPath.row], bounty: bountyList[indexPath.row])

        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.data = dataList[indexPath.item]
        present(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = (self.view.frame.width - 10) / 2
        let height: CGFloat = width * 10/7 + 65

        return CGSize(width: width, height: height)
    }
}

/*
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }

        var data = pageData()

        data.img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        data.name = self.nameList[indexPath.row]
        data.bounty = self.bountyList[indexPath.row]

        cell.imgView.image = data.img
        cell.name.text = data.name
        cell.bounty.text = data.bounty

        cell.name.sizeToFit()
        cell.bounty.sizeToFit()

        self.dataList.append(data)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.data = dataList[indexPath.row]
        present(vc, animated: true)
    }
}
 */

