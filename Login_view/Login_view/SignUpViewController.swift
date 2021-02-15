//
//  SignUpViewController.swift
//  Login_view
//
//  Created by sangho Cho on 2021/02/15.
//

import Foundation
import UIKit

class SignUpViewConroller: UIViewController {

  // MARK: UI

  private let imageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "main"))
    return imageView
  }()
  private let inputID: UITextField = {
    let textField = UITextField()
    textField.placeholder = "ID"
    return textField
  }()
  private let inputPW: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password"
    return textField
  }()
  private let inputPWCheck: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password Check"
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
      imageView.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
      imageView.widthAnchor.constraint(equalTo: margin.widthAnchor, multiplier: 0.3),
      imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor)

    ])
    
  }

}
