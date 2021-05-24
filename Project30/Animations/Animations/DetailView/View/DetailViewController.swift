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


  // MARK: Animate Button

  @objc private func changeAnimate(_ sender: UIButton) {
    switch self.animateType {
    case .twoColor:
      self.changeColor(.green)

    case .simple2DRotation:
      self.rotateView(Double.pi)

    case .multiColor:
      self.multiColor(.green, .blue)

    case .multiPointPosition:
      self.multiPosition(CGPoint(x: self.animateView.frame.origin.x, y: 100), CGPoint(x: self.animateView.frame.origin.x, y: 350))

    case .bezrierCurvePosition:
      var controlPoint1 = self.animateView.center
      controlPoint1.y -= 125.0
      var controlPoint2 = controlPoint1
      controlPoint2.x += 40.0
      controlPoint2.y -= 125.0

      var endPoint = self.animateView.center
      endPoint.x += 75.0
      self.curvePath(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)

    case .colorAndFrameChange:
      let currentFrame = self.animateView.frame
      let firstFrame = currentFrame.insetBy(dx: -30, dy: -50)
      let secondFrame = firstFrame.insetBy(dx: 10, dy: 15)
      let thirdFrame = secondFrame.insetBy(dx: -15, dy: -20)
      self.colorFrameChange(firstFrame, secondFrame, thirdFrame, .orange, .yellow, .green)

    case .viewFadeIn:
      self.viewFadeIn()

    case .pop:
      self.pop()

    default:
      break
    }
  }


  // MARK: Do Animate

  private func changeColor(_ color: UIColor) {
    UIView.animate(withDuration: self.duration) {
      self.animateView.backgroundColor = color
    }
  }

  private func multiColor(_ firstColor: UIColor, _ secondColor: UIColor) {
    UIView.animate(withDuration: self.duration, animations: {
      self.animateView.backgroundColor = firstColor
    }) { _ in
      self.changeColor(secondColor)
    }
  }

  private func multiPosition(_ firstPos: CGPoint, _ secondPos: CGPoint) {
    func simplePosition(_ pos: CGPoint) {
      UIView.animate(withDuration: self.duration) {
        self.animateView.frame.origin = pos
      }
    }

    UIView.animate(withDuration: self.duration, animations: {
      self.animateView.frame.origin = firstPos
    }) { _ in
      simplePosition(secondPos)
    }
  }

  private func rotateView(_ angle: Double) {
    UIView.animate(withDuration: self.duration, delay: self.delay, options: [.repeat], animations: {
      self.animateView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    })
  }

  private func colorFrameChange(_ firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect, _ firstColor: UIColor, _ secondColor: UIColor, _ thirdColor: UIColor) {
    UIView.animate(withDuration: self.duration, animations: {
      self.animateView.backgroundColor = firstColor
      self.animateView.frame = firstFrame
    }) { _ in
      UIView.animate(withDuration: self.duration, animations: {
        self.animateView.backgroundColor = secondColor
        self.animateView.frame = secondFrame
      }) { _ in
        UIView.animate(withDuration: self.duration, animations: {
          self.animateView.backgroundColor = thirdColor
          self.animateView.frame = thirdFrame
        })
      }
    }
  }

  private func curvePath(_ endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
    let path = UIBezierPath()
    path.move(to: self.animateView.center)

    path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)

    let anim = CAKeyframeAnimation(keyPath: "position")

    anim.path = path.cgPath

    anim.duration = self.duration

    self.animateView.layer.add(anim, forKey: "animate position along path")
    self.animateView.center = endPoint
  }

  private func viewFadeIn() {
    let secondView = UIImageView(image: UIImage(named: "facebook"))
    secondView.frame = self.animateView.frame
    secondView.alpha = 0.0

    self.view.insertSubview(secondView, aboveSubview: self.animateView)

    UIView.animate(withDuration: self.duration, delay: self.delay, options: .curveEaseOut) {
      secondView.alpha = 1.0
      self.animateView.alpha = 0.0
    }
  }

  private func pop() {
    UIView.animate(withDuration: duration / 4, animations: {
      self.animateView.transform = CGAffineTransform(scaleX: CGFloat(self.scale), y: CGFloat(self.scale))
    }) { _ in
      UIView.animate(withDuration: self.duration / 4, animations: {
        self.animateView.transform = CGAffineTransform.identity
      })
    }
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


