//
//  StopWatchViewController.swift
//  StopWatch
//
//  Created by sangho Cho on 2021/04/29.
//

import Foundation
import UIKit
import SnapKit

class StopWatchViewController: UIViewController {


  // MARK: UI

  let currentTimer: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 40)
    label.text = "00.00.00"
    return label
  }()
  let checkTimer: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    label.text = "00.00.00"
    return label
  }()
  let lapAndReset: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Reset", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    return button
  }()
  let startAndStop: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Start", for: .normal)
    button.setTitleColor(.systemGreen, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    return button
  }()
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.allowsSelection = false
    return tableView
  }()


  // MARK: Properties

  private var viewModel: StopWatchViewModel


  // MARK: Initializing

  init(viewModel: StopWatchViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configuration()
  }

  
  // MARK: Configuration

  private func configuration() {
    self.viewConfiguration()
    self.layout()
  }

  private func viewConfiguration() {
    self.view.backgroundColor = .systemBackground
    self.navigationItem.title = "Stopwatch"
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.checkTimer)
    self.view.addSubview(self.currentTimer)
    self.view.addSubview(self.lapAndReset)
    self.view.addSubview(self.startAndStop)
    self.view.addSubview(self.tableView)

    self.currentTimer.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(100)
    }
    self.checkTimer.snp.makeConstraints{
      $0.trailing.equalTo(self.currentTimer.snp.trailing)
      $0.bottom.equalTo(self.currentTimer.snp.top).offset(-10)
    }
    self.lapAndReset.snp.makeConstraints{
      $0.top.equalTo(self.currentTimer.snp.bottom).offset(70)
      $0.centerX.equalToSuperview().offset(-50)
    }
    self.startAndStop.snp.makeConstraints{
      $0.top.equalTo(self.lapAndReset)
      $0.centerX.equalToSuperview().offset(50)
    }
    self.tableView.snp.makeConstraints{
      $0.top.equalTo(self.lapAndReset.snp.bottom).offset(50)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}
