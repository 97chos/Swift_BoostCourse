//
//  TableViewCell.swift
//  SimpleRSSReader
//
//  Created by sangho Cho on 2021/05/11.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {

  // MARK: UI

  private let newsTitleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    label.numberOfLines = 0
    return label
  }()
  private let newsDateLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    label.textColor = .darkGray
    return label
  }()
  private (set) var newsDescriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18)
    label.numberOfLines = 4
    return label
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

  func set(rss: RSSItem) {
    self.newsTitleLabel.text = rss.title
    self.newsDateLabel.text = rss.pubDate
    self.newsDescriptionLabel.text = rss.description
  }

  func changeLines(cellState: CellState) {
    self.newsDescriptionLabel.numberOfLines = cellState == .expanded ? 0 : 4
  }


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(self.newsTitleLabel)
    self.contentView.addSubview(self.newsDateLabel)
    self.contentView.addSubview(self.newsDescriptionLabel)

    self.newsTitleLabel.snp.makeConstraints{
      $0.top.equalToSuperview().inset(20)
      $0.leading.equalToSuperview().inset(20)
      $0.trailing.equalToSuperview().inset(20)
    }
    self.newsDateLabel.snp.makeConstraints {
      $0.top.equalTo(self.newsTitleLabel.snp.bottom).inset(-5)
      $0.leading.equalTo(self.newsTitleLabel)
    }
    self.newsDescriptionLabel.snp.makeConstraints{
      $0.top.equalTo(self.newsDateLabel.snp.bottom).inset(-10)
      $0.bottom.equalToSuperview().inset(10)
      $0.leading.trailing.equalTo(self.newsTitleLabel)
    }
  }

}
