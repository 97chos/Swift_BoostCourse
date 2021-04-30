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

  let mainTimer: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 40)
    label.text = "00.00.00"
    label.sizeToFit()
    return label
  }()
  let lapTimer: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    label.text = "00.00.00"
    label.textAlignment = .right
    return label
  }()
  let lapAndResetButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Reset", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.backgroundColor = .white
    return button
  }()
  let startAndStopButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Start", for: .normal)
    button.setTitleColor(.systemGreen, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.backgroundColor = .white
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

  override func viewDidLayoutSubviews() {
    self.makeCircleButton(self.lapAndResetButton)
    self.makeCircleButton(self.startAndStopButton)
  }
  

  // MARK: Configuration

  private func configuration() {
    self.viewConfiguration()
    self.layout()
    self.buttonConfiguration()
    self.tableViewConfiguration()
  }

  private func viewConfiguration() {
    self.view.backgroundColor = .systemGray4
    self.navigationItem.title = "Stopwatch"

    self.viewModel.delegate = self
  }

  private func tableViewConfiguration() {
    self.tableView.dataSource = self
    self.tableView.register(LapTableViewCell.self, forCellReuseIdentifier: "cell")
    self.tableView.rowHeight = 40
  }

  private func buttonConfiguration() {
    self.startAndStopButton.addTarget(self, action: #selector(self.runStopAction), for: .touchUpInside)
    self.lapAndResetButton.addTarget(self, action: #selector(self.lapResetAction), for: .touchUpInside)
  }


  // MARK: Functions

  @objc private func runStopAction() {
    self.viewModel.runAndStop {
      switch self.viewModel.isRunning {
      case .running:
        self.changeButton(self.startAndStopButton, "Start", .systemGreen)
        self.lapAndResetButton.setTitle("Reset", for: .normal)

      case .stop:
        self.changeButton(self.startAndStopButton, "Stop", .systemRed)
        self.lapAndResetButton.setTitle("Lap", for: .normal)
      }
    }
  }

  @objc private func lapResetAction() {
    self.viewModel.lapReset(mainTime: self.mainTimer.text, lapTime: self.lapTimer.text) {
      if self.viewModel.isRunning == .stop {
        self.mainTimer.text = "00:00:00"
        self.lapTimer.text = "00:00:00"
      }
      self.tableView.reloadData()
    }
  }

  private func changeButton(_ button: UIButton, _ title: String, _ color: UIColor) {
    button.setTitle(title, for: .normal)
    button.setTitleColor(color, for: .normal)
  }

  private func makeCircleButton(_ button: UIButton) {
    button.layer.cornerRadius = button.frame.width / 2
    button.layer.masksToBounds = true
  }


  // MARK: Layout

  private func layout() {
    self.view.addSubview(self.lapTimer)
    self.view.addSubview(self.mainTimer)
    self.view.addSubview(self.lapAndResetButton)
    self.view.addSubview(self.startAndStopButton)
    self.view.addSubview(self.tableView)

    self.mainTimer.snp.makeConstraints{
      $0.leading.equalTo(self.view.frame.width/2).inset(self.mainTimer.frame.width/1.5)
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(100)
    }
    self.lapTimer.snp.makeConstraints{
      $0.leading.equalTo(self.mainTimer.snp.leading)
      $0.bottom.equalTo(self.mainTimer.snp.top).offset(-10)
    }
    self.lapAndResetButton.snp.makeConstraints{
      $0.width.height.equalTo(70)
      $0.top.equalTo(self.mainTimer.snp.bottom).offset(70)
      $0.centerX.equalToSuperview().offset(-70)
    }
    self.startAndStopButton.snp.makeConstraints{
      $0.width.height.equalTo(70)
      $0.top.equalTo(self.lapAndResetButton)
      $0.centerX.equalToSuperview().offset(70)
    }
    self.tableView.snp.makeConstraints{
      $0.top.equalTo(self.lapAndResetButton.snp.bottom).offset(50)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

extension StopWatchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.laps.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LapTableViewCell else {
      return UITableViewCell()
    }

    cell.set(lapCount: "Lap \(self.viewModel.laps.count - indexPath.row)", times: self.viewModel.laps[indexPath.row])

    return cell
  }
}

extension StopWatchViewController: UpdateTimerLabelDelegate {
  func updateTimer(stopwatch: Stopwatch, _ text: String) {
    switch stopwatch.watchType {
    case .main:
      self.mainTimer.text = text
    case .lap:
      self.lapTimer.text = text
    }
  }
}
