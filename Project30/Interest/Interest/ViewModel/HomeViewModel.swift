//
//  HomeViewModel.swift
//  Interest
//
//  Created by sangho Cho on 2021/05/15.
//

import Foundation
import UIKit

class HomeViewModel {

  // MARK: Properties

  private (set) var interests: [Interest] = []


  // MARK: Initializing

  init() {
    self.interests = self.createInterests()
  }


  // MARK: Functions

  private func createInterests() -> [Interest] {
    return [
      Interest(id: "r1", title: "We Love Traveling Around the World", description: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r1")!),
      Interest(id: "r2", title: "Romance Stories", description: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r2")!),
      Interest(id: "r3", title: "iOS Dev", description: "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r3")!),
      Interest(id: "r4", title: "Race", description: "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r4")!),
      Interest(id: "r5", title: "Personal Development", description: "Meet life with full presence. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r5")!),
      Interest(id: "r6", title: "Reading News", description: "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r6")!),
    ]
  }

}
