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

class StopWatchViewModel {

  // MARK: Properties

  var isRunning: State = .stop
  var laps: [StopwatchTimeModel] = []
  private var mainTimer: Stopwatch = Stopwatch(.main)
  private var lapTimer: Stopwatch = Stopwatch(.lap)

  private var lapCount = 1


  // MARK: Functions

  @objc func changeState() {
    
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

}
