//
//  ViewController.swift
//  MyAlbum
//
//  Created by sangho Cho on 2021/02/18.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    self.configure()
  }


  // MARK: Configuration

  private func configure() {
    self.viewConfigure()
  }

  private func viewConfigure() {
    self.title = "MyAlbum"
    self.view.backgroundColor = .systemBackground
  }


}

