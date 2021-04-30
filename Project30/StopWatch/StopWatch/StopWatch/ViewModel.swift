//
//  ViewModel.swift
//  StopWatch
//
//  Created by sangho Cho on 2021/04/29.
//

import Foundation

enum State {
  case running
  case stop
}

protocol UpdateTimerLabelDelegate: class {
  func updateTimer(stopwatch: Stopwatch,_ text: String)
}

class StopWatchViewModel {

  // MARK: Properties

  var isRunning: State = .stop
  var laps: [StopwatchTimeModel] = []
  private var mainTimer: Stopwatch = Stopwatch(.main)
  private var lapTimer: Stopwatch = Stopwatch(.lap)

  weak var delegate: UpdateTimerLabelDelegate?

  private var lapCount = 1


  // MARK: Button Actions

  @objc func runAndStop(completion: () -> Void) {
    switch self.isRunning {
    case .stop:
      self.mainTimer.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(self.updateMainTimer), userInfo: nil, repeats: true)
      self.lapTimer.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(self.updateLabTimer), userInfo: nil, repeats: true)

      RunLoop.current.add(self.mainTimer.timer, forMode: RunLoop.Mode.common)
      RunLoop.current.add(self.lapTimer.timer, forMode: RunLoop.Mode.common)

      completion()
      self.isRunning = .running
    case .running:
      self.mainTimer.timer.invalidate()
      self.lapTimer.timer.invalidate()

      completion()
      self.isRunning = .stop
    }
  }

  @objc func lapReset(mainTime: String?, lapTime: String?, completion: () -> Void) {
    switch self.isRunning {
    case .running:
      if let mainTime = mainTime, let lapTime = lapTime {
        laps.insert(StopwatchTimeModel(lapTime: lapTime, mainTime: mainTime),at: 0)
      }
      completion()
      resetLapTimer()
      lapTimer.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateLabTimer), userInfo: nil, repeats: true)

      RunLoop.current.add(self.lapTimer.timer, forMode: .common)
    case .stop:
      resetMainTimer()
      resetLapTimer()
      completion()
    }
  }


  // MARK: Update Timer

  @objc private func updateMainTimer() {
    self.updateTimer(self.mainTimer)
  }

  @objc private func updateLabTimer() {
    self.updateTimer(self.lapTimer)
  }

  private func updateTimer(_ stopwatch: Stopwatch) {
    stopwatch.counter += 0.035

    var minutes: String = "\(Int(stopwatch.counter / 60))"
    var seconds: String = String(format: "%.2f", stopwatch.counter.truncatingRemainder(dividingBy: 60))

    if Int(stopwatch.counter / 60) < 10 {
      minutes = "0\(Int(stopwatch.counter / 60))"
    }

    if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
      seconds = "0" + seconds
    }

    self.delegate?.updateTimer(stopwatch: stopwatch, minutes+":"+seconds)
  }


  // MARK: Reset Timer

  private func resetMainTimer() {
    self.resetTimer(self.mainTimer)
    self.laps.removeAll()
  }

  private func resetLapTimer() {
    self.resetTimer(self.lapTimer)
  }

  private func resetTimer(_ stopwatch: Stopwatch) {
    stopwatch.timer.invalidate()
    stopwatch.counter = 0.0
  }

}
