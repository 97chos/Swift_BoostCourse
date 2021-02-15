//
//  ViewController.swift
//  Login_view
//
//  Created by sangho Cho on 2021/02/15.
//

import UIKit

class MainViewController: UIViewController {

  // MARK: Properties

  private let userInformation = UserInformation.shared


  // MARK: UI

  private let mainImageView: UIImageView = {
    let imgView = UIImageView(image: UIImage(named: "main.png"))
    return imgView
  }()
  private let inputID: UITextField = {
    let textField = UITextField()
    textField.placeholder = "ID"
    textField.borderStyle = .roundedRect
    return textField
  }()
  private let inputPW: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password"
    textField.isSecureTextEntry = true
    textField.borderStyle = .roundedRect
    return textField
  }()
  private let signInButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign In", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.sizeToFit()
    return button
  }()
  private let signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.setTitleColor(.systemRed, for: .normal)
    button.setTitleColor(.systemGray, for: .disabled)
    button.sizeToFit()
    return button
  }()
  private let buttonContainerView: UIView = {
    let view = UIView(frame: CGRect.zero)
    view.backgroundColor = .systemBackground
    return view
  }()


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.layout()
    self.setButtonsAction()
  }

  override func viewWillAppear(_ animated: Bool) {
    if let id = self.userInformation.ID {
      self.inputID.text = id
    } else {
      self.inputID.text = ""
    }
  }

  // MARK: Action

  @objc func signUpButtonAction() {
    let signUpVC = SignUpViewConroller()
    let naviagationVC = UINavigationController(rootViewController: signUpVC)
    naviagationVC.modalPresentationStyle = .fullScreen
    self.present(naviagationVC, animated: true)
  }

  // MARK: Configuration

  private func setButtonsAction() {
    self.signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
  }


  private func layout() {

    self.view.backgroundColor = .systemBackground

    self.view.addSubview(self.mainImageView)
    self.view.addSubview(self.inputID)
    self.view.addSubview(self.inputPW)
    self.view.addSubview(self.buttonContainerView)
    self.buttonContainerView.addSubview(self.signInButton)
    self.buttonContainerView.addSubview(self.signUpButton)

    self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
    self.inputID.translatesAutoresizingMaskIntoConstraints = false
    self.inputPW.translatesAutoresizingMaskIntoConstraints = false
    self.signInButton.translatesAutoresizingMaskIntoConstraints = false
    self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
    self.buttonContainerView.translatesAutoresizingMaskIntoConstraints = false

    let margin = self.view.layoutMarginsGuide

    NSLayoutConstraint.activate([
      mainImageView.topAnchor.constraint(equalTo: margin.topAnchor, constant: 20),
      mainImageView.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
      mainImageView.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.3),
      mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor),

      inputID.topAnchor.constraint(equalTo: self.mainImageView.bottomAnchor, constant: 20),
      inputID.widthAnchor.constraint(equalTo: mainImageView.widthAnchor),
      inputID.centerXAnchor.constraint(equalTo: margin.centerXAnchor),

      inputPW.topAnchor.constraint(equalTo: self.inputID.bottomAnchor, constant: 10),
      inputPW.widthAnchor.constraint(equalTo: self.inputID.widthAnchor),
      inputPW.centerXAnchor.constraint(equalTo: self.inputID.centerXAnchor),

      buttonContainerView.topAnchor.constraint(equalTo: self.inputPW.bottomAnchor, constant: 20),
      buttonContainerView.widthAnchor.constraint(equalTo: self.inputID.widthAnchor, multiplier: 0.8),
      buttonContainerView.heightAnchor.constraint(equalTo: self.inputID.heightAnchor),
      buttonContainerView.centerXAnchor.constraint(equalTo: margin.centerXAnchor),

      signInButton.topAnchor.constraint(equalTo: self.buttonContainerView.topAnchor),
      signInButton.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),

      signUpButton.topAnchor.constraint(equalTo: self.buttonContainerView.topAnchor),
      signUpButton.trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor)
    ])
  }
}


