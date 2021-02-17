//
//  weatherDetailViewController.swift
//  weatherToday
//
//  Created by sangho Cho on 2021/02/17.
//

import Foundation
import UIKit
import SnapKit

class WhetherDetailViewController: UIViewController {

  // MARK: Properties

  private let city: City!

  // MARK: UI


  // MARK: Initializing

  init(city: City) {
    self.city = city
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
  }


  // MARK: Congigure

  private func configure() {
    self.viewConfigure()
  }

  private func viewConfigure() {
    self.view.backgroundColor = .systemBackground
  }
}
