//
//  ViewController.swift
//  Tumblr
//
//  Created by sangho Cho on 2021/05/19.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {

  // MARK: UI

  let textImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "Text")
    return imageView
  }()
  let chatImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "Chat")
    return imageView
  }()
  let linkImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "Link")
    return imageView
  }()
  let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "Photo")
    return imageView
  }()
  let quoteImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "Quote")
    return imageView
  }()
  let audioImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "Audio")
    return imageView
  }()
  let textLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.text = "Text"
    label.textColor = .white
    return label
  }()
  let chatLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.text = "Chat"
    label.textColor = .white
    return label
  }()
  let linkLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.text = "Link"
    label.textColor = .white
    return label
  }()
  let photoLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.text = "Photo"
    label.textColor = .white
    return label
  }()
  let quoteLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.text = "Quote"
    label.textColor = .white
    return label
  }()
  let audioLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.text = "Audio"
    label.textColor = .white
    return label
  }()
  lazy var cancelButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Cancel", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20)
    button.addTarget(self, action: #selector(self.closeModal), for: .touchUpInside)
    return button
  }()


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configuration()
    self.layout()
  }


  // MARK: Configuration

  private func configuration() {
    self.configureView()
  }

  private func configureView() {
    self.view.backgroundColor = .black
  }


  // MARK: Set Button

  @objc private func closeModal() {
    self.dismiss(animated: true)
  }

  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.textImageView)
    self.view.addSubview(self.audioImageView)
    self.view.addSubview(self.chatImageView)
    self.view.addSubview(self.linkImageView)
    self.view.addSubview(self.photoImageView)
    self.view.addSubview(self.quoteImageView)
    self.view.addSubview(self.audioLabel)
    self.view.addSubview(self.chatLabel)
    self.view.addSubview(self.linkLabel)
    self.view.addSubview(self.photoLabel)
    self.view.addSubview(self.quoteLabel)
    self.view.addSubview(self.textLabel)
    self.view.addSubview(self.cancelButton)

    self.textImageView.snp.makeConstraints{
      $0.top.equalToSuperview().inset(100)
      $0.width.height.equalTo(100)
      $0.leading.equalToSuperview().inset(50)
    }
    self.textLabel.snp.makeConstraints{
      $0.top.equalTo(self.textImageView.snp.bottom).inset(10)
      $0.centerX.equalTo(self.textImageView)
    }
    self.quoteImageView.snp.makeConstraints{
      $0.top.equalTo(self.textLabel.snp.bottom).inset(-20)
      $0.width.height.equalTo(100)
      $0.centerX.equalTo(self.textLabel)
    }
    self.quoteLabel.snp.makeConstraints{
      $0.top.equalTo(self.quoteImageView.snp.bottom).inset(10)
      $0.centerX.equalTo(self.quoteImageView)
    }
    self.chatImageView.snp.makeConstraints{
      $0.top.equalTo(self.quoteLabel.snp.bottom).inset(-20)
      $0.width.height.equalTo(100)
      $0.centerX.equalTo(self.quoteLabel)
    }
    self.chatLabel.snp.makeConstraints{
      $0.top.equalTo(self.chatImageView.snp.bottom).inset(10)
      $0.centerX.equalTo(self.quoteImageView)
    }
    self.photoImageView.snp.makeConstraints{
      $0.top.equalTo(self.textImageView)
      $0.width.height.equalTo(100)
      $0.trailing.equalToSuperview().inset(50)
    }
    self.photoLabel.snp.makeConstraints{
      $0.top.equalTo(self.textLabel)
      $0.centerX.equalTo(self.photoImageView)
    }
    self.linkImageView.snp.makeConstraints{
      $0.top.equalTo(self.quoteImageView)
      $0.width.height.equalTo(100)
      $0.centerX.equalTo(self.photoLabel)
    }
    self.linkLabel.snp.makeConstraints{
      $0.top.equalTo(self.quoteLabel)
      $0.centerX.equalTo(self.linkImageView)
    }
    self.audioImageView.snp.makeConstraints{
      $0.top.equalTo(self.chatImageView)
      $0.width.height.equalTo(100)
      $0.centerX.equalTo(self.linkLabel)
    }
    self.audioLabel.snp.makeConstraints{
      $0.top.equalTo(self.chatLabel)
      $0.centerX.equalTo(self.audioImageView)
    }
    self.cancelButton.snp.makeConstraints{
      $0.bottom.equalToSuperview().inset(50)
      $0.centerX.equalToSuperview()
    }
  }
}

