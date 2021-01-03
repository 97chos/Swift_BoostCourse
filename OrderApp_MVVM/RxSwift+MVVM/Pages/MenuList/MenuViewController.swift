//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    // MARK: - Life Cycle

    let viewModel = MenuListViewModel()
    var disposeBag = DisposeBag()

    let cellId = "MenuItemTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = nil                  // 데이터 소스 없이 Observable로 자동으로 바인딩 되도록 처리

        // menuObservable 값이 바뀌면, 해당 값에 대한 셀의 값을 바꾸는 구문 (index: 해당 셀의 인덱스, item: menu 배열의 단일 객체, cell: 단일 셀 (dequeue 역할))
        viewModel.menuObservable
            .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: MenuItemTableViewCell.self)) { index, item, cell in
                cell.title.text = item.name
                cell.price.text = "\(item.price)"
                cell.count.text = "\(item.count)"

                cell.onChange = { [weak self] increase in
                    self?.viewModel.changeCount(item: item, increase: increase)
                }

            }
            .disposed(by: disposeBag)


        viewModel.itemsCount
            .map{"\($0)"}
            .bind(to: itemCountLabel.rx.text)       // RxCocoa : subscribe를 대신할 축약 구문
//            .subscribe(onNext: {
//                self.itemCountLabel.text = $0
//            })
            .disposed(by: disposeBag)

        viewModel.totalPrice
            .map { $0.currencyKR() }
            .subscribe(onNext: {
                self.totalPrice.text = $0
            })
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
        viewModel.clearAllItemSecletions()
    }

    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
        // performSegue(withIdentifier: "OrderViewController", sender: nil)

        viewModel.menuObservable.onNext([
            Menu(id: 0, name: "changed", price: Int.random(in: 100...1000), count: Int.random(in: 1...5)),
            Menu(id: 1, name: "changed", price: Int.random(in: 100...1000), count: Int.random(in: 1...5)),
            Menu(id: 2, name: "changed", price: Int.random(in: 100...1000), count: Int.random(in: 1...5)),
            Menu(id: 3, name: "changed", price: Int.random(in: 100...1000), count: Int.random(in: 1...5))
        ])
    }

    func updateUI() {
        itemCountLabel.text = "\(viewModel.itemsCount)"
        // totalPrice.text = viewModel.totalPrice.currencyKR()
    }
}

// extension MenuViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.menus.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell") as! MenuItemTableViewCell
//
//        let menu = viewModel.menus[indexPath.row]
//
//        cell.title.text = menu.name
//        cell.price.text = "\(menu.price)"
//        cell.count.text = "\(menu.count)"
//
//        return cell
//    }
// }
