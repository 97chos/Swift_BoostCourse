//
//  ListViewCell.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/14.
//

import Foundation
import UIKit
import SnapKit

class ListViewCell: UITableViewCell {

  // MARK: UI

  private let posterImgView: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 17)
    return label
  }()
  private let movieInforLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let openDataLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12)
    return label
  }()
  private let gradeImgView: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    return imgView
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

  func set(movie: Movie) {
    var movie = movie
    self.getPosterImage(movie)
    self.getGradeImage(movie)
    self.titleLabel.text = movie.title
    self.movieInforLabel.text = movie.movieInformation
    self.openDataLabel.text = "개봉일: \(movie.date)"
  }

  private func getPosterImage(_ movie: Movie) {
    guard let url = URL(string: movie.thumb) else { return }
    do {
      let imageData = try Data(contentsOf: url)
      let image = UIImage(data: imageData)
      self.posterImgView.image = image
    } catch(let error) {
      print(error.localizedDescription)
    }
  }

  private func getGradeImage(_ movie: Movie) {
    switch movie.grade {
    case 12:
      self.gradeImgView.image = UIImage(named: "ic_12")
    case 15:
      self.gradeImgView.image = UIImage(named: "ic_15")
    case 19:
      self.gradeImgView.image = UIImage(named: "ic_19")
    case 0:
      self.gradeImgView.image = UIImage(named: "ic_allages")
    default:
      self.gradeImgView.image = nil
    }
  }


  // MARK: Layout

  private func layout() {
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.gradeImgView)
    self.contentView.addSubview(self.movieInforLabel)
    self.contentView.addSubview(self.openDataLabel)
    self.contentView.addSubview(self.posterImgView)

    self.posterImgView.snp.makeConstraints {
      $0.height.equalToSuperview().multipliedBy(0.9)
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
    }
    self.movieInforLabel.snp.makeConstraints{
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(self.posterImgView.snp.trailing).offset(10)
    }
    self.titleLabel.snp.makeConstraints{
      $0.bottom.equalTo(self.movieInforLabel.snp.top).offset(-10)
      $0.leading.equalTo(self.movieInforLabel)
    }
    self.gradeImgView.snp.makeConstraints{
      $0.leading.equalTo(self.titleLabel.snp.trailing).offset(10)
      $0.top.equalTo(self.titleLabel)
    }
    self.openDataLabel.snp.makeConstraints{
      $0.top.equalTo(self.movieInforLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.movieInforLabel)
    }
  }
}
