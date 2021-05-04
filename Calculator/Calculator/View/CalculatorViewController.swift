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
  private let viewModel: CalculatorViewModel


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
  private let inputNumberLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 60)
    label.textColor = .white
    label.textAlignment = .right
    label.text = "0"
    label.adjustsFontSizeToFitWidth = true
    return label
  }()


  //MARK: Initialzing

  init(viewModel: CalculatorViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  //MARK: View LifeCycle

  override func viewDidLoad() {
    self.configuration()
    self.layout()
  }

  override func viewDidLayoutSubviews() {
  }


  //MARK: Configuration

  private func configuration() {
    self.view.backgroundColor = .black
    self.viewModel.delegate = self
  }


  //MARK: Functions

  private func makeKeypadStackView() -> UIStackView {
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

    buttons.forEach{ buttons in
      buttons.forEach {
        if $0.tag != 0 {
          $0.addTarget(self, action: #selector(self.numberPadAction(_:)), for: .touchUpInside)
        } else {
          $0.addTarget(self, action: #selector(self.functionPadAction(_:)), for: .touchUpInside)
        }
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

  @objc private func numberPadAction(_ button: UIButton) {
    self.viewModel.didTapNumberButton(button.tag)
  }

  @objc private func functionPadAction(_ button: UIButton) {
    self.viewModel.didTapFunctionButton(button.titleLabel?.text ?? "")
  }


  // MARK: Layout

  private func layout() {
    let keypadView = self.makeKeypadStackView()

    self.view.addSubview(keypadView)
    self.view.addSubview(self.inputNumberLabel)

    keypadView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }
    inputNumberLabel.snp.makeConstraints {
      $0.bottom.equalTo(keypadView.snp.top).offset(-20)
      $0.trailing.equalToSuperview().inset(10)
      $0.leading.equalToSuperview().inset(10)
    }
  }
}


extension CalculatorViewController: TappedKeypadDelegate {
  func tappedNumberKeypad(number: String) {
    self.inputNumberLabel.text = number
  }

  func tappedFunctionKeypad(function: String) {

  }
}
