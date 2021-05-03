//
//  DetailViewController.swift
//  CandySearch
//
//  Created by sangho Cho on 2021/05/03.
//

import Foundation
import UIKit
import SnapKit

class DetailViewController: UIViewController {

  // MARK: UI

  private let candyName: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 17)
    return label
  }()
  private let candyImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()


  // MARK: Properties

  private let candy: Candy


  // MARK: Initializing

  init(candy: Candy) {
    self.candy = candy
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configuration()
  }


  // MARK: Configuration

  private func configuration() {
    self.configureView()
    self.layout()
  }

  private func configureView() {
    self.view.backgroundColor = .systemBackground
    self.navigationItem.title = self.candy.name
    self.candyName.text = self.candy.name
    self.candyImage.image = UIImage(named: self.candy.name)
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.candyName)
    self.view.addSubview(self.candyImage)

    self.candyName.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(30)
    }

    self.candyImage.snp.makeConstraints{
      $0.center.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
    }
  }

}
