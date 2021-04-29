//
//  Stopwatch.swift
//  StopWatch
//
//  Created by sangho Cho on 2021/04/29.
//

import Foundation

enum StopwatchType {
  case main
  case lap
}

class Stopwatch {
  var counter: Double
  var timer: Timer
  let watchType: StopwatchType

  init(_ type: StopwatchType) {
    self.counter = 0.0
    self.timer = Timer()
    self.watchType = type
  }
}
