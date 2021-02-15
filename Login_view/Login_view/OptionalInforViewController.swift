//
//  OptionalInforViewController.swift
//  Login_view
//
//  Created by sangho Cho on 2021/02/15.
//

import Foundation
import UIKit

class OptionalInforViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: Properties

  private var pickerDate: String?

  // MARK: UI

  private let phoneNumberLabel: UILabel = {
    let label = UILabel()
    label.text = "전화번호"
    label.sizeToFit()
    return label
  }()
  private let phoneNumberTextField: UITextField = {
    let textField = UITextField()
    textField.keyboardType = .numberPad
    return textField
  }()
  private let birthLabel: UILabel = {
    let label = UILabel()
    label.text = "생년월일"
    label.sizeToFit()
    return label
  }()
  private let selectedBirthLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  private lazy var birthPicker: UIDatePicker = {
    let picker = UIDatePicker()
    picker.datePickerMode = .date
    return picker
  }()
  private let ButtonContainerView: UIView = {
    let view = UIView()
    return view
  }()
  private let cancelButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("취소", for: .normal)
    button.setTitleColor(.systemRed, for: .normal)
    return button
  }()
  private let previousButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("이전", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    return button
  }()
  private let joinButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("가입", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.isEnabled = false
    return button
  }()


}

