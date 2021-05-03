//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by sangho Cho on 2021/05/03.
//

import Foundation
import UIKit
import SnapKit

class CalculatorViewController: UIViewController {

  //MARK: Properties
  private let additionalFunctions: [String] = ["%","+/-","AC"]
  private let functions: [String] = ["÷","x","-","+","="]
  private var allButtons: [[UIButton]] = [[]]


  //MARK: UI

  private lazy var numberButtons: [UIButton] = (0...9).map { number -> UIButton in
    let button = self.makeButton(element: number, color: .darkGray)
    if number == 0 {
      button.tag = 10
    } else {
      button.tag = number
    }
    return button
  }
  private lazy var additionalFunctionbuttons: [UIButton] = self.additionalFunctions.map { function -> UIButton in
    let button = self.makeButton(element: function, color: .lightGray)
    return button
  }


  //MARK: View LifeCycle

  override func viewDidLoad() {
    self.configuration()
    self.layout()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    self.allButtons.forEach {
      $0.forEach{ button in
        print(button.frame.width)
        button.layer.borderWidth = button.layer.frame.width * 0.5
        button.layer.masksToBounds = true
      }
    }
  }


  //MARK: Configuration

  private func configuration() {

  }


  //MARK: Functions

  private func setButtonPads() -> UIStackView {
    let allButtons: [[UIButton]] = self.addAllButton()
    self.allButtons = allButtons

    let horizontalStackViews = allButtons.map { buttons -> UIStackView in
      let horizontalStackView: UIStackView = UIStackView(arrangedSubviews: buttons)
      horizontalStackView.axis = .horizontal
      horizontalStackView.alignment = .fill

      if buttons.count == 4 {
        horizontalStackView.distribution = .fillEqually
      } else {
        horizontalStackView.distribution = .fillProportionally
      }
      return horizontalStackView
    }

    allButtons.forEach {
      $0.forEach { button in
        if button.tag == 10 {
          button.snp.makeConstraints {
            $0.width.equalTo(button.snp.width).multipliedBy(2)
            $0.height.equalTo(button.snp.width).multipliedBy(0.5)
          }
        } else {
          button.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(button.snp.width)
          }
        }
      }
    }

    let keyPadStackView = UIStackView(arrangedSubviews: horizontalStackViews)
    keyPadStackView.alignment = .fill
    keyPadStackView.distribution = .fillEqually
    keyPadStackView.axis = .vertical

    return keyPadStackView
  }

  private func addAllButton() -> [[UIButton]] {
    var buttons: [[UIButton]] = [[]]

    buttons = self.numberButtons
      .reversed() // 0~9 를 9~0 으로 변경
      .chunked(into: 3) // [9,8,7,6...3,2,1,0] 을 [[9,8,7],[6,5,4],[3,2,1],[0]] 으로 변경

    buttons.insert(self.additionalFunctionbuttons, at: 0)

    for i in 0..<buttons.count {
      buttons[i].reverse()  // [9,8,7] 을 [7,8,9] 로 변경
      if buttons[i] != buttons.last {
        buttons[i].append(self.makeButton(element: self.functions[i], color: .systemYellow))
      } else {
        buttons[i].append(self.makeButton(element: ".", color: .darkGray))
        buttons[i].append(self.makeButton(element: self.functions[i], color: .systemYellow))
      }
    }

    return buttons
  }

  private func makeButton<T: Equatable>(element: T, color: UIColor) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("\(element)", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = color
    button.titleLabel?.font = .systemFont(ofSize: 18)
    return button
  }


  // MARK: Layout

  private func layout() {
    let keypadView = self.setButtonPads()

    self.view.addSubview(keypadView)

    keypadView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
}
