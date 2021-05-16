//
//  SceneDelegate.swift
//  Interest
//
//  Created by sangho Cho on 2021/05/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = HomeViewController(viewModel: HomeViewModel())
    self.window?.windowScene = scene
    self.window?.makeKeyAndVisible()
  }



}

