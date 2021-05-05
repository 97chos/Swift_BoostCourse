//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by sangho Cho on 2021/05/04.
//

import Foundation

protocol TappedKeypadDelegate: class {
  func tappedNumberKeypad(number: String)
}


class CalculatorViewModel {

  // MARK: Properties

  private var newValue: Float = 0
  private var oldValue: Float = 0
  private var displayedValue: Float = 0
  private var tempValue: Float = 0
  private var currentState: Functions = .equal

  private var isInputting: Bool = true

  weak var delegate: TappedKeypadDelegate?


  // MARK: Functions

  @objc func didTapNumberButton(_ tag: Int) {

    if !self.isInputting {
      self.oldValue = self.newValue
      self.newValue = self.tempValue
      self.tempValue = 0
    }

    self.isInputting = true

    self.displayedValue = self.numberPad(tag)

    guard -922337217429372928 < displayedValue && displayedValue < 922337203685477580 else { return }

    if Float(Int(displayedValue)) == displayedValue {
      self.delegate?.tappedNumberKeypad(number: "\(Int(displayedValue))")
    } else {
      self.delegate?.tappedNumberKeypad(number: "\(displayedValue)")
    }
  }

  @objc func didTapFunctionButton(_ rawValue: Functions.RawValue) {
    guard let function = Functions(rawValue: rawValue) else { return }

    self.functionPad(function)

    guard -922337217429372928 < self.displayedValue && self.displayedValue < 922337203685477580 else { return }

    if Float(Int(self.displayedValue)) == self.displayedValue {
      self.delegate?.tappedNumberKeypad(number: "\(Int(self.displayedValue))")
    } else {
      self.delegate?.tappedNumberKeypad(number: "\(self.displayedValue)")
    }

    self.tempValue = displayedValue

    if self.oldValue != 0 {
      self.isInputting = false
    }

    if self.currentState != .changePlusMinus {
      self.displayedValue = 0
    }
  }

  private func numberPad(_ number: Int) -> Float {
    if number == 10 && self.displayedValue == 0 {
      return 0
    } else if self.displayedValue == 0 {
      return Float(number)
    } else {
      if number == 10 {
        return Float("\(Int(self.displayedValue))0") ?? 0
      } else {
        return Float("\(Int(self.displayedValue))\(number)") ?? 0
      }
    }
  }

  private func functionPad(_ function: Functions) {
      switch function {
      case .AC:
        self.newValue = 0
        self.oldValue = 0
        self.displayedValue = 0
        self.tempValue = 0

      case .changePlusMinus:
        if self.displayedValue != 0 {
          self.displayedValue = -(self.displayedValue)
        }
      case .percent:
        if oldValue != 0 {
          self.oldValue = max(self.oldValue + (self.newValue / self.oldValue * 100),0)
        } else {
          self.oldValue = newValue / 100
        }
        self.oldValue = newValue
      case .plus, .multiply, .minus, .divide:
        if displayedValue == 0 {
          self.displayedValue = self.tempValue
        }
        self.fourRulesPad(function)
        self.currentState = function

      case .equal:
        self.equalPad(self.currentState)
        self.currentState = .equal
        self.tempValue = 0
      }
      self.currentState = function
  }

  private func fourRulesPad(_ function: Functions) {
    self.oldValue = self.newValue
    self.newValue = self.displayedValue

    if self.oldValue != 0 && self.newValue != 0 {
      self.calculate(function)
    }
  }

  private func equalPad(_ function: Functions) {
    self.oldValue = self.newValue
    self.newValue = self.displayedValue
    self.calculate(function)
  }

  private func calculate(_ function: Functions) {
    switch function {
    case .plus:
      self.displayedValue = self.oldValue + self.newValue
    case .minus:
      self.displayedValue = self.oldValue - self.newValue
    case .divide:
      self.displayedValue = self.oldValue / self.newValue
    case .multiply:
      self.displayedValue = self.oldValue * self.newValue
    default:
      return
    }
  }

}
