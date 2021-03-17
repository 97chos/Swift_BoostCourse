//
//  ReviewWriteViewController.swift
//  BoxOffice
//
//  Created by sangho Cho on 2021/03/17.
//

import Foundation
import UIKit
import SnapKit

protocol InputtedReviewDelegate: class {
  func addReview(review: ReviewModel) -> ()
}

class ReviewWriteViewController: UIViewController {

  // MARK: Properties

  private let viewModel: ReviewWriteViewModel
  weak var delegate: InputtedReviewDelegate?

  // MARK: UI

  private lazy var slider: UISlider = {
    var slider = UISlider()
    slider.minimumValue = 0
    slider.maximumValue = 10
    slider.isContinuous = true
    slider.addTarget(self, action: #selector(self.changeValue), for: .valueChanged)
    return slider
  }()
  private let movieTitle: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    return label
  }()
  private let gradeImage: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  private let ratingLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let topView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    return view
  }()
  private let inputTitle: UITextField = {
    let field = UITextField()
    field.borderStyle = .bezel
    return field
  }()
  private let inputReview: UITextView = {
    let view = UITextView()
    view.layer.borderWidth = 0.5
    view.font = .systemFont(ofSize: 15)
    return view
  }()
  private let bottomView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    return view
  }()
  private lazy var doneButton: UIBarButtonItem = {
    let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.clickedButton))
    return button
  }()


  // MARK: Initializing

  init(viewModel: ReviewWriteViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.congifure()
    self.changeValue()
  }


  // MARK: Functions

  @objc private func changeValue() {
    self.ratingLabel.text = "\(round(self.slider.value / 0.5)*0.5)"
  }

  @objc private func clickedButton() {
    guard let writer = self.inputTitle.text else { return }
    guard let contents = self.inputReview.text else { return }
    self.viewModel.done(rating: self.slider.value, writer: writer, contents: contents) { result in
      switch result{
      case .success(let review):
        DispatchQueue.main.async {
          self.delegate?.addReview(review: review)
          self.navigationController?.popViewController(animated: true)
        }
      case .failure(let error):
        let errorType = error as? APIError
        print((errorType?.description)!)
      }
    }
  }


  // MARK: Congifuration

  private func congifure() {
    self.viewConfigure()
    self.layout()
  }

  private func viewConfigure() {
    self.title = "한줄평 작성"
    self.movieTitle.text = self.viewModel.movie.title
    self.view.backgroundColor = .systemGray6
    self.gradeImage.image = GetImage.getGradeImage(self.viewModel.movie)
    self.navigationItem.rightBarButtonItem = self.doneButton
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.topView)
    self.topView.addSubview(self.movieTitle)
    self.topView.addSubview(self.slider)
    self.topView.addSubview(self.gradeImage)
    self.topView.addSubview(self.ratingLabel)
    self.view.addSubview(self.bottomView)
    self.bottomView.addSubview(self.inputTitle)
    self.bottomView.addSubview(self.inputReview)

    self.topView.snp.makeConstraints{
      $0.top.leading.width.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.3)
    }
    self.bottomView.snp.makeConstraints{
      $0.top.equalTo(self.topView.snp.bottom).offset(10)
      $0.bottom.leading.width.equalToSuperview()
    }
    self.movieTitle.snp.makeConstraints{
      $0.top.leading.equalTo(self.view.safeAreaLayoutGuide).inset(10)
    }
    self.gradeImage.snp.makeConstraints{
      $0.top.equalTo(self.movieTitle)
      $0.leading.equalTo(self.movieTitle.snp.trailing).offset(5)
    }
    self.slider.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(80)
      $0.width.equalToSuperview().multipliedBy(0.8)
    }
    self.ratingLabel.snp.makeConstraints{
      $0.top.equalTo(self.slider.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
    }
    self.inputTitle.snp.makeConstraints{
      $0.width.equalToSuperview().multipliedBy(0.9)
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(10)
    }
    self.inputReview.snp.makeConstraints{
      $0.top.equalTo(self.inputTitle.snp.bottom).offset(10)
      $0.width.equalTo(self.inputTitle)
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
    }
  }
}
