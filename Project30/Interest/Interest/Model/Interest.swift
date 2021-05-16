//
//  Interest.swift
//  Interest
//
//  Created by sangho Cho on 2021/05/15.
//

import Foundation
import UIKit

struct Interest {

  var id: String
  var title: String
  var description: String
  var numberOfMembers: Int
  var numberOfPosts: Int
  var featuredImage: UIImage

  init(id: String, title: String, description: String, featuredImage: UIImage) {
    self.id = id
    self.title = title
    self.description = description
    self.featuredImage = featuredImage
    self.numberOfMembers = 1
    self.numberOfPosts = 1
  }
}
