//
//  UserInformation.swift
//  Login_view
//
//  Created by sangho Cho on 2021/02/15.
//

import Foundation


class UserInformation {
  static let shared = UserInformation()
  var ID: String?
  var PW: String?
  var Information: String?

  private init() {
    
  }
}
