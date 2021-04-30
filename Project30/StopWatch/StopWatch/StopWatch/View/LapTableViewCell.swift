//
//  LapTableViewCell.swift
//  StopWatch
//
//  Created by sangho Cho on 2021/04/29.
//

import Foundation
import UIKit
import SnapKit

class LapTableViewCell: UITableViewCell {

  // MARK: UI

  private let lapLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()
  private let mainTimeLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()
  private let lapTimeLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()


  // MARK: Initializing

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.layout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(lapCount: String, times: StopwatchTimeModel) {
    self.lapLabel.text = lapCount
    self.mainTimeLabel.text = times.mainTime
    self.lapTimeLabel.text = "+ \(times.lapTime)"
  }


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(self.lapLabel)
    self.contentView.addSubview(self.mainTimeLabel)
    self.contentView.addSubview(self.lapTimeLabel)

    self.lapLabel.snp.makeConstraints{
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    self.mainTimeLabel.snp.makeConstraints{
      $0.center.equalToSuperview()
    }
    self.lapTimeLabel.snp.makeConstraints{
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
  }

}
