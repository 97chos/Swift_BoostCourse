//
//  ViewController.swift
//  Interest
//
//  Created by sangho Cho on 2021/05/12.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  // MARK: UI

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

