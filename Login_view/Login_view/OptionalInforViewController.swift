//
//  OptionalInforViewController.swift
//  Login_view
//
//  Created by sangho Cho on 2021/02/15.
//

import Foundation
import UIKit

class OptionalInforViewController: UIViewController {

  // MARK: Properties

  private var pickerDate: String?
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
  }()


  // MARK: UI

  private let phoneNumberLabel: UILabel = {
    let label = UILabel()
    label.text = "전화번호"
    label.font = .systemFont(ofSize: 15)
    label.sizeToFit()
    return label
  }()
  private let phoneNumberTextField: UITextField = {
    let textField = UITextField()
    textField.keyboardType = .numberPad
    textField.borderStyle = .roundedRect
    return textField
  }()
  private let birthLabel: UILabel = {
    let label = UILabel()
    label.text = "생년월일"
    label.font = .systemFont(ofSize: 15)
    label.sizeToFit()
    return label
  }()
  private lazy var selectedBirthLabel: UILabel = {
    let label = UILabel()
    label.text = self.dateFormatter.string(from: Date())
    return label
  }()
  private lazy var birthPicker: UIDatePicker = {
    let picker = UIDatePicker()
    picker.datePickerMode = .date
    picker.preferredDatePickerStyle = .wheels
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


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
  }


  // MARK: Configuration

  private func configure() {
    self.viewConfigure()
    self.layout()
    self.actionConfigure()
  }

  private func viewConfigure() {
    self.navigationItem.title = "Additional Information"
    self.view.backgroundColor = .systemBackground
  }

  private func actionConfigure() {
    self.birthPicker.addTarget(self, action: #selector(self.pickerValueChanged(_:)), for: .valueChanged)
  }


  // MARK: Action

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.phoneNumberTextField.resignFirstResponder()
  }

  @objc private func pickerValueChanged(_ sender: UIDatePicker) {
    let currentDate = self.dateFormatter.string(from: sender.date)
    self.selectedBirthLabel.text = currentDate
  }


  // MARK: Layout

  func layout() {

    self.view.addSubview(self.phoneNumberLabel)
    self.view.addSubview(self.phoneNumberTextField)
    self.view.addSubview(self.birthLabel)
    self.view.addSubview(self.birthPicker)
    self.view.addSubview(self.selectedBirthLabel)
    self.view.addSubview(self.ButtonContainerView)
    self.ButtonContainerView.addSubview(self.cancelButton)
    self.ButtonContainerView.addSubview(self.previousButton)
    self.ButtonContainerView.addSubview(self.joinButton)

    self.phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    self.phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
    self.birthLabel.translatesAutoresizingMaskIntoConstraints = false
    self.birthPicker.translatesAutoresizingMaskIntoConstraints = false
    self.selectedBirthLabel.translatesAutoresizingMaskIntoConstraints = false
    self.ButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
    self.previousButton.translatesAutoresizingMaskIntoConstraints = false
    self.joinButton.translatesAutoresizingMaskIntoConstraints = false


    let margin = self.view.layoutMarginsGuide

    NSLayoutConstraint.activate([
      phoneNumberLabel.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10),
      phoneNumberLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

      phoneNumberTextField.topAnchor.constraint(equalTo: self.phoneNumberLabel.bottomAnchor, constant: 5),
      phoneNumberTextField.widthAnchor.constraint(equalTo: margin.widthAnchor),
      phoneNumberTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

      birthLabel.topAnchor.constraint(equalTo: self.phoneNumberTextField.bottomAnchor, constant: 10),
      birthLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

      selectedBirthLabel.topAnchor.constraint(equalTo: self.birthLabel.topAnchor),
      selectedBirthLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),

      birthPicker.topAnchor.constraint(equalTo: self.birthLabel.bottomAnchor, constant: 10),
      birthPicker.widthAnchor.constraint(equalTo: margin.widthAnchor, multiplier: 0.9),
      birthPicker.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.3),
      birthPicker.centerXAnchor.constraint(equalTo: margin.centerXAnchor),

      ButtonContainerView.topAnchor.constraint(equalTo: self.birthPicker.bottomAnchor, constant: 20),
      ButtonContainerView.widthAnchor.constraint(equalTo: margin.widthAnchor, multiplier: 0.8),
      ButtonContainerView.heightAnchor.constraint(equalTo: self.joinButton.heightAnchor),
      ButtonContainerView.centerXAnchor.constraint(equalTo: margin.centerXAnchor),

      cancelButton.topAnchor.constraint(equalTo: self.ButtonContainerView.topAnchor),
      cancelButton.leadingAnchor.constraint(equalTo: self.ButtonContainerView.leadingAnchor),

      previousButton.topAnchor.constraint(equalTo: self.ButtonContainerView.topAnchor),
      previousButton.centerXAnchor.constraint(equalTo: self.ButtonContainerView.centerXAnchor),

      joinButton.topAnchor.constraint(equalTo: self.ButtonContainerView.topAnchor),
      joinButton.trailingAnchor.constraint(equalTo: self.ButtonContainerView.trailingAnchor)
    ])
  }


}

