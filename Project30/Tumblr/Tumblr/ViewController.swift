//
//  ViewController.swift
//  Tumblr
//
//  Created by sangho Cho on 2021/05/19.
//

import Foundation
import SnapKit

class ViewController: UIViewController {

  // MARK: UI

  private let toolbar: UIToolbar = {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    return toolbar
  }()
  private let searchButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
    return button
  }()
  private lazy var showMenuButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.showMenu))
    return button
  }()
  private let refreshButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
    return button
  }()


  // MARK: Properties

  private let transition = AnimationTransition()

  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configuration()
    self.layout()
  }


  // MARK: Configuraion

  private func configuration() {
    self.configureView()
  }

  private func configureView() {
    self.view.backgroundColor = .systemBackground
  }


  // MARK: Functions

  @objc private func showMenu() {
    let menuVC: MenuViewController = MenuViewController()
    menuVC.transitioningDelegate = self
    self.present(menuVC, animated: true)
  }

  private func layout() {
    self.toolbar.setItems([self.searchButton, UIBarButtonItem(systemItem: .flexibleSpace) ,self.showMenuButton, UIBarButtonItem(systemItem: .flexibleSpace), self.refreshButton], animated: true)

    self.view.addSubview(self.toolbar)

    self.toolbar.snp.makeConstraints{
      $0.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
}


extension ViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = true
    return transition
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = false
    return transition
  }
}
