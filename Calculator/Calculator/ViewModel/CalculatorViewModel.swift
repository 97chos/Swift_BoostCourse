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
    self.newNumber = self.numberPad(tag)
    guard -922337217429372928 < newNumber && newNumber < 922337203685477580 else { return }
    if Float(Int(newNumber)) == newNumber {
      self.delegate?.tappedNumberKeypad(number: "\(Int(newNumber))")
    } else {
      self.delegate?.tappedNumberKeypad(number: "\(newNumber)")
    }
  }

  @objc func didTapFunctionButton(_ rawValue: Functions.RawValue) {
    guard let function = Functions(rawValue: rawValue) else { return }
    self.functionPad(function)
    guard -922337217429372928 < resultNumber && resultNumber < 922337203685477580 else { return }

    if Float(Int(resultNumber)) == resultNumber {
      self.delegate?.tappedNumberKeypad(number: "\(Int(resultNumber))")
    } else {
      self.delegate?.tappedNumberKeypad(number: "\(resultNumber)")
    }
  }

  private func numberPad(_ number: Int) -> Float {
    if number == 10 && self.newNumber == 0 {
      return 0
    } else if self.newNumber == 0 {
      return Float(number)
    } else {
      if number == 10 {
        return Float("\(Int(self.newNumber))0") ?? 0
      } else {
        return Float("\(Int(self.newNumber))\(number)") ?? 0
      }
    }
  }

  private func functionPad(_ function: Functions) {
      switch function {
      case .AC:
        self.newNumber = 0
        self.resultNumber = 0
        self.currentState = .equal
      case .changePlusMinus:
        if self.newNumber != 0 {
          if self.resultNumber == 0 {
            self.resultNumber = self.newNumber
          }
          self.newNumber = -(self.resultNumber)
          self.resultNumber = newNumber
        }
      case .percent:
        if resultNumber != 0 {
          self.resultNumber = max(self.resultNumber + (self.newNumber / self.resultNumber * 100),0)
        } else {
          self.resultNumber = newNumber / 100
        }
        self.resultNumber = newNumber
      case .plus, .multiply, .minus, .divide:
        guard self.currentState != function else { return }
        self.currentState = function

        if resultNumber == 0 {
          resultNumber = newNumber
        }
        newNumber = 0
      case .equal:
        self.fourRulesPad(self.currentState)
        self.currentState = .equal
      }
      self.currentState = function
  }

  private func fourRulesPad(_ function: Functions) {
    switch function {
    case .plus:
      self.resultNumber += self.newNumber
    case .minus:
      self.resultNumber -= self.newNumber
    case .divide:
      self.resultNumber /= self.newNumber
    case .multiply:
      self.resultNumber *= self.newNumber
    default:
      return
    }
    self.newNumber = 0
  }

}
