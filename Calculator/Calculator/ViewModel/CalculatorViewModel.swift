//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by sangho Cho on 2021/05/04.
//

import Foundation

protocol TappedKeypadDelegate: class {
  func tappedNumberKeypad(number: String)
  func tappedFunctionKeypad(function: String)
}


class CalculatorViewModel {

  // MARK: Properties

  private var newNumber: Float = 0
  private var oldNumber: Float = 0
  private var displayedNumber: Float = 0
  private var tempNumber: Float = 0
  private var currentState: Functions = .equal

  weak var delegate: TappedKeypadDelegate?


  // MARK: Functions

  @objc func didTapNumberButton(_ tag: Int) {
    self.displayedNumber = self.numberPad(tag)

    guard -922337217429372928 < displayedNumber && displayedNumber < 922337203685477580 else { return }

    if Float(Int(displayedNumber)) == displayedNumber {
      self.delegate?.tappedNumberKeypad(number: "\(Int(displayedNumber))")
    } else {
      self.delegate?.tappedNumberKeypad(number: "\(displayedNumber)")
    }
  }

  @objc func didTapFunctionButton(_ rawValue: Functions.RawValue) {
    guard let function = Functions(rawValue: rawValue) else { return }

    self.functionPad(function)

    guard -922337217429372928 < self.displayedNumber && self.displayedNumber < 922337203685477580 else { return }

    if Float(Int(self.displayedNumber)) == self.displayedNumber {
      self.delegate?.tappedNumberKeypad(number: "\(Int(self.displayedNumber))")
    } else {
      self.delegate?.tappedNumberKeypad(number: "\(self.displayedNumber)")
    }

    if self.currentState != .changePlusMinus {
      self.displayedNumber = 0
    }
  }

  private func numberPad(_ number: Int) -> Float {
    if number == 10 && self.displayedNumber == 0 {
      return 0
    } else if self.displayedNumber == 0 {
      return Float(number)
    } else {
      if number == 10 {
        return Float("\(Int(self.displayedNumber))0") ?? 0
      } else {
        return Float("\(Int(self.displayedNumber))\(number)") ?? 0
      }
    }
  }

  private func functionPad(_ function: Functions) {
      switch function {
      case .AC:
        self.newNumber = 0
        self.oldNumber = 0
        self.displayedNumber = 0
        self.tempNumber = 0

      case .changePlusMinus:
        if self.displayedNumber != 0 {
          self.displayedNumber = -(self.displayedNumber)
        }
      case .percent:
        if oldNumber != 0 {
          self.oldNumber = max(self.oldNumber + (self.newNumber / self.oldNumber * 100),0)
        } else {
          self.oldNumber = newNumber / 100
        }
        self.oldNumber = newNumber
      case .plus, .multiply, .minus, .divide:
        self.fourRulesPad(function)
        self.currentState = function

      case .equal:
        self.equalPad(self.currentState)
        self.currentState = .equal
        self.tempNumber = 0
      }
      self.currentState = function
  }

  private func fourRulesPad(_ function: Functions) {
    self.oldNumber = self.newNumber
    self.newNumber = self.displayedNumber

    if self.oldNumber != 0 && self.newNumber != 0 {
      self.calculate(function)
    }
  }

  private func equalPad(_ function: Functions) {
    self.calculate(function)
  }

  private func calculate(_ function: Functions) {
    self.oldNumber = self.newNumber
    self.newNumber = self.displayedNumber

    switch function {
    case .plus:
      self.displayedNumber = self.oldNumber + self.newNumber
    case .minus:
      self.displayedNumber = self.oldNumber - self.newNumber
    case .divide:
      self.displayedNumber = self.oldNumber / self.newNumber
    case .multiply:
      self.displayedNumber = self.oldNumber * self.newNumber
    default:
      return
    }
  }

}
