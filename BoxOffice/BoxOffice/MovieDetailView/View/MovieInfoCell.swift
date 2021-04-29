//
//  MovieInfoCell.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/15.
//

import Foundation
import UIKit
import SnapKit

class MovieInfoCell: UITableViewCell {

  // MARK: UI

  private let thumbnailView: UIImageView = {
    let imgView = UIImageView()
    let img = UIImage(named: "img_placeholder")
    img?.accessibilityIdentifier = AccessbilityIdentifier.imagePlaceholderIdentifier
    imgView.contentMode = .scaleAspectFit
    imgView.image = img
    return imgView
  }()
  private let gradeImageView: UIImageView = {
    let imgView = UIImageView()
    return imgView
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    return label
  }()
  private let openDateLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let etcInfoLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let ticketingRateLabel: UILabel = {
    let label = UILabel()
    label.text = "예매율"
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()
  private let ticketingRate: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let evaluationRateLabel: UILabel = {
    let label = UILabel()
    label.text = "평점"
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()
  private let evaluationRate: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let audienceLabel: UILabel = {
    let label = UILabel()
    label.text = "누적관객수"
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()
  private let audience: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
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


  // MARK: Set

  func set(movie: MovieInfoModel) {
    if self.thumbnailView.image?.accessibilityIdentifier == AccessbilityIdentifier.imagePlaceholderIdentifier {
      self.thumbnailView.image = GetImage.getThumbImage(movie)
      self.thumbnailView.sizeToFit()

      self.gradeImageView.image = GetImage.getGradeImage(movie)

      self.titleLabel.text = movie.title
      self.openDateLabel.text = "\(movie.date) 개봉"
      self.etcInfoLabel.text = "\(movie.genre)/\(movie.duration)분"
      self.ticketingRate.text = "\(movie.reservationGrade)위 \(movie.reservationRate)%"
      self.evaluationRate.text = "\(movie.userRating)"
      self.audience.text = movie.audience.cutDecimal()
    }
  }


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(self.thumbnailView)
    self.contentView.addSubview(self.gradeImageView)
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.openDateLabel)
    self.contentView.addSubview(self.etcInfoLabel)
    self.contentView.addSubview(self.ticketingRateLabel)
    self.contentView.addSubview(self.ticketingRate)
    self.contentView.addSubview(self.evaluationRateLabel)
    self.contentView.addSubview(self.evaluationRate)
    self.contentView.addSubview(self.audienceLabel)
    self.contentView.addSubview(self.audience)

    thumbnailView.snp.makeConstraints{
      $0.top.equalToSuperview().inset(5)
      $0.leading.equalToSuperview().inset(5)
      $0.height.equalTo(225)
      $0.width.equalTo(150)
    }
    etcInfoLabel.snp.makeConstraints{
      $0.bottom.equalTo(self.thumbnailView)
      $0.leading.equalTo(self.thumbnailView.snp.trailing).offset(10)
    }
    openDateLabel.snp.makeConstraints{
      $0.bottom.equalTo(self.etcInfoLabel.snp.top).offset(-5)
      $0.leading.equalTo(self.etcInfoLabel)
    }
    titleLabel.snp.makeConstraints{
      $0.bottom.equalTo(self.openDateLabel.snp.top).offset(-5)
      $0.leading.equalTo(self.etcInfoLabel)
    }
    gradeImageView.snp.makeConstraints{
      $0.leading.equalTo(self.titleLabel.snp.trailing).offset(5)
      $0.centerY.equalTo(self.titleLabel)
    }
    evaluationRateLabel.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.thumbnailView.snp.bottom).offset(20)
    }
    evaluationRate.snp.makeConstraints{
      $0.centerX.equalTo(self.evaluationRateLabel)
      $0.top.equalTo(self.evaluationRateLabel.snp.bottom).offset(10)
      $0.bottom.equalToSuperview().offset(-10)
    }
    ticketingRateLabel.snp.makeConstraints{
      $0.top.equalTo(self.evaluationRateLabel)
      $0.leading.equalToSuperview().inset(50)
    }
    ticketingRate.snp.makeConstraints{
      $0.centerX.equalTo(self.ticketingRateLabel)
      $0.bottom.equalTo(self.evaluationRate)
    }
    audienceLabel.snp.makeConstraints{
      $0.top.equalTo(self.evaluationRateLabel)
      $0.trailing.equalToSuperview().inset(50)
    }
    audience.snp.makeConstraints{
      $0.centerX.equalTo(self.audienceLabel)
      $0.bottom.equalTo(self.evaluationRate)
    }
  }


}
