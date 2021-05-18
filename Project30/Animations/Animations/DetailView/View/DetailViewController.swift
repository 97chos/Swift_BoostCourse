//
//  DetailViewController.swift
//  Animations
//
//  Created by sangho Cho on 2021/05/18.
//

import Foundation
import SnapKit

class DetailViewController: UIViewController {

  // MARK: UI

  private var animateView: UIView = {
    let view = UIView()
    return view
  }()
  private let animateButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Animate", for: .normal)
    return button
  }()


  // MARK: Properties

  private var animateType: AnimationType?
  private let duration: Double = 2.0
  private let delay: Double = 0.2
  private let scale: Double = 1.2


  // MARK: Initializing

  init(animateType: AnimationType) {
    self.animateType = animateType
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configuration()
    self.layout()
  }


  // MARK: Configuration

  private func configuration() {
    self.configureView()
    self.setupAnimateView()
    self.configureButton()
  }

  private func configureView() {
    self.navigationItem.title = self.animateType?.rawValue
    self.view.backgroundColor = .systemBackground
  }

  private func configureButton() {
    self.animateButton.addTarget(self, action: #selector(self.changeAnimate(_:)), for: .touchUpInside)
  }


  // MARK: Setup AnimateView

  private func setupAnimateView() {
    if self.animateType == .bezrierCurvePosition {
      self.animateView = self.drawCircleView()
    } else if self.animateType == .viewFadeIn {
      self.animateView = UIImageView(image: UIImage(named: "whatsapp"))
      self.animateView.center = self.view.center
    } else {
      self.animateView = self.drawRectView(color: .magenta)
    }

    self.view.addSubview(self.animateView)
  }


  // MARK: Draw AnimateView

  private func drawCircleView() -> UIView {
    let view = UIView(frame: CGRect(x: 100, y: 350, width: 100, height: 100))

    view.backgroundColor = .red
    view.layer.cornerRadius = view.frame.width / 2
    view.layer.masksToBounds = false

    return view
  }

  private func drawRectView(color: UIColor) -> UIView {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    view.center = self.view.center
    view.backgroundColor = color

    return view
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.animateButton)

    self.animateButton.snp.makeConstraints{
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(50)
      $0.centerX.equalToSuperview()
    }
  }
}
