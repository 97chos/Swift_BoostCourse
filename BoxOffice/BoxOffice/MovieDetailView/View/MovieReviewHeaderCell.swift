//
//  MovieReviewHeaderCell.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/16.
//

import Foundation
import UIKit

protocol PushViewControllerDelegate: class {
  func pushViewController()
}

class MoviewReviewHeaderCell: UITableViewCell {

  // MARK: Properties

  weak var delegate: PushViewControllerDelegate?


  // MARK: UI

  private let title: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.text = "한줄평"
    return label
  }()
  private lazy var button: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "btn_compose"), for: .normal)
    button.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
    return button
  }()


  // MARK: Initailizing

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Set

  @objc private func clickBtn() {
    self.delegate?.pushViewController()
  }


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(self.title)
    self.contentView.addSubview(self.button)

    self.title.snp.makeConstraints{
      $0.top.equalToSuperview().inset(5)
      $0.leading.equalToSuperview().inset(5)
      $0.bottom.equalToSuperview().inset(5)
    }
    self.button.snp.makeConstraints{
      $0.top.equalTo(self.title)
      $0.trailing.equalToSuperview().offset(-5)
      $0.bottom.equalTo(self.title)
    }
  }
}
