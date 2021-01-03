//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by sangho Cho on 2021/01/03.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay                      // UI 작업 특성 상 에러가 발생해도 스트림이 끊어지지 않게 하기 위해 추가된 라이브러리

class MenuListViewModel {

    lazy var menuObservable = BehaviorRelay<[Menu]>(value: [])          // 에러가 나도 스트림이 끊어지지 않는 서브젝트

    lazy var itemsCount = menuObservable.map {
        $0.map{ $0.count }.reduce(0, +)
    }

    lazy var totalPrice = menuObservable.map {
        $0.map{ $0.price * $0.count }.reduce(0, +)
    }


    init() {

        _ = APIService.fetchAllMenusRx()
            .map { data -> [MenuItem] in
                struct Response: Decodable {
                    let menus: [MenuItem]
                }
                let response = try! JSONDecoder().decode(Response.self, from: data)

                return response.menus
            }
            .map { menuItems -> [Menu]  in
                var menus: [Menu] = []
                menuItems.enumerated().forEach{ index, item in
                    let menu = Menu.fromMenuItems(id: index, item: item)
                    menus.append(menu)
                }
                return menus
            }
            .take(1)
            .bind(to: menuObservable)
    }

    func clearAllItemSecletions() {
        menuObservable.map { menus in
            menus.map { m in
                Menu(id: m.id, name: m.name, price: m.price, count: 0)
            }
        }
        .take(1)
        .subscribe(onNext: {
            self.menuObservable.accept($0)                  // onNext를 대신할 relay 메소드
        })
    }

    func changeCount(item: Menu, increase: Int) {
        menuObservable.map { menus in
            menus.map { m in
                if m.id == item.id {
                    return Menu(id: m.id, name: m.name, price: m.price, count: max(m.count + increase, 0))
                } else {
                    return Menu(id: m.id, name: m.name, price: m.price, count: m.count)
                }
            }
        }
        .take(1)
        .subscribe(onNext: {
            self.menuObservable.accept($0)
        })
    }
}
