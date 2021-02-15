//
//  SignUpViewController.swift
//  Login_view
//
//  Created by sangho Cho on 2021/02/15.
//

import Foundation
import UIKit

class SignUpViewConroller: UIViewController {

  // MARK: Properties
  private let userInformation = UserInformation.shared

  // MARK: UI

  private let imageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "main"))
    return imageView
  }()
  private lazy var inputID: UITextField = {
    let textField = UITextField()
    textField.placeholder = "ID"
    textField.spellCheckingType = .no
    textField.autocorrectionType = .no
    textField.keyboardType = .alphabet
    textField.autocapitalizationType = .none
    textField.delegate = self
    textField.borderStyle = .roundedRect
    return textField
  }()
  private lazy var inputPW: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password"
    textField.isSecureTextEntry = true
    textField.textContentType = .oneTimeCode
    textField.delegate = self
    textField.borderStyle = .roundedRect
    return textField
  }()
  private lazy var inputPWCheck: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password Check"
    textField.isSecureTextEntry = true
    textField.textContentType = .oneTimeCode
    textField.delegate = self
    textField.borderStyle = .roundedRect
    return textField
  }()
  private let textFieldContainer: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    return view
  }()
  private let inputInformation: UITextView = {
    let view = UITextView()
    view.backgroundColor = .systemYellow
    return view
  }()
  private let cancelButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("취소", for: .normal)
    button.setTitleColor(.systemRed, for: .normal)
    return button
  }()
  private let OkButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("확인", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.systemGray, for: .disabled)
    button.isEnabled = false
    return button
  }()
  private let buttonContainer: UIView = {
    let view = UIView()
    view.backgroundColor = .none
    return view
  }()


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.layout()
    self.configure()
  }

  // MARK: Congifuration

  private func configure() {
    self.viewConfigure()
    self.ActionConfigure()
  }

  private func viewConfigure() {
    self.navigationItem.title = "Sign Up"
  }

  private func ActionConfigure() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedImageView(_:)))
    self.imageView.addGestureRecognizer(tapGesture)
    self.imageView.isUserInteractionEnabled = true

    self.OkButton.addTarget(self, action: #selector(self.selectedButton(_:)), for: .touchUpInside)
    self.cancelButton.addTarget(self, action: #selector(self.selectedButton(_:)), for: .touchUpInside)
  }


  // MARK: Action

  @objc private func selectedImageView(_ sender: UITapGestureRecognizer) {
    let imagePickerVC = UIImagePickerController()
    imagePickerVC.allowsEditing = true
    imagePickerVC.delegate = self

    self.present(imagePickerVC, animated: true)
  }

  @objc private func selectedButton(_ sender: UIButton) {
    switch sender {
    case self.OkButton:
      self.userInformation.ID = self.inputID.text
      let optionalVC = OptionalInforViewController()
      self.navigationController?.pushViewController(optionalVC, animated: true)
    case self.cancelButton:
      self.userInformation.ID = nil
      self.dismiss(animated: true)
    default:
      break
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.inputInformation.resignFirstResponder()
  }

  // MARK: Layout

  private func layout() {

    self.view.backgroundColor = .systemBackground

    self.view.addSubview(self.imageView)
    self.view.addSubview(self.textFieldContainer)
    self.textFieldContainer.addSubview(self.inputID)
    self.textFieldContainer.addSubview(self.inputPW)
    self.textFieldContainer.addSubview(self.inputPWCheck)
    self.view.addSubview(self.inputInformation)
    self.view.addSubview(self.buttonContainer)
    self.buttonContainer.addSubview(self.OkButton)
    self.buttonContainer.addSubview(self.cancelButton)

    self.imageView.translatesAutoresizingMaskIntoConstraints = false
    self.inputID.translatesAutoresizingMaskIntoConstraints = false
    self.inputPW.translatesAutoresizingMaskIntoConstraints = false
    self.inputInformation.translatesAutoresizingMaskIntoConstraints = false
    self.inputPWCheck.translatesAutoresizingMaskIntoConstraints = false
    self.textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
    self.buttonContainer.translatesAutoresizingMaskIntoConstraints = false
    self.OkButton.translatesAutoresizingMaskIntoConstraints = false
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = false

    let margin = self.view.layoutMarginsGuide

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10),
      imageView.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 5),
      imageView.widthAnchor.constraint(equalTo: margin.widthAnchor, multiplier: 0.3),
      imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor),

      textFieldContainer.topAnchor.constraint(equalTo: imageView.topAnchor),
      textFieldContainer.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
      textFieldContainer.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
      textFieldContainer.heightAnchor.constraint(equalTo: imageView.heightAnchor),

      inputID.topAnchor.constraint(equalTo: self.textFieldContainer.topAnchor),
      inputID.widthAnchor.constraint(equalTo: self.textFieldContainer.widthAnchor),

      inputPW.centerYAnchor.constraint(equalTo: self.textFieldContainer.centerYAnchor),
      inputPW.widthAnchor.constraint(equalTo: self.inputID.widthAnchor),

      inputPWCheck.bottomAnchor.constraint(equalTo: self.textFieldContainer.bottomAnchor),
      inputPWCheck.widthAnchor.constraint(equalTo: self.inputPW.widthAnchor),

      inputInformation.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10),
      inputInformation.widthAnchor.constraint(equalTo: margin.widthAnchor),
      inputInformation.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.7),
      inputInformation.centerXAnchor.constraint(equalTo: margin.centerXAnchor),

      buttonContainer.topAnchor.constraint(equalTo: self.inputInformation.bottomAnchor, constant: 10),
      buttonContainer.widthAnchor.constraint(equalTo: margin.widthAnchor),
      buttonContainer.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
      buttonContainer.centerXAnchor.constraint(equalTo: margin.centerXAnchor),

      cancelButton.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
      cancelButton.centerYAnchor.constraint(equalTo: self.buttonContainer.centerYAnchor),
      cancelButton.widthAnchor.constraint(equalTo: self.buttonContainer.widthAnchor, multiplier: 0.5),

      OkButton.trailingAnchor.constraint(equalTo: self.buttonContainer.trailingAnchor),
      OkButton.centerYAnchor.constraint(equalTo: self.buttonContainer.centerYAnchor),
      OkButton.widthAnchor.constraint(equalTo: self.buttonContainer.widthAnchor, multiplier: 0.5)
    ])
  }
}

extension SignUpViewConroller: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.editedImage] as? UIImage
    self.imageView.image = image

    self.dismiss(animated: true)
  }
}

extension SignUpViewConroller: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

    guard textField.text?.isEmpty == false else {
      self.OkButton.isEnabled = false
      return true
    }

    if self.inputPW.text == self.inputPWCheck.text && !(inputID.text?.isEmpty ?? true) {
      self.OkButton.isEnabled = true
    } else {
      self.OkButton.isEnabled = false
    }

    return true
  }
}
