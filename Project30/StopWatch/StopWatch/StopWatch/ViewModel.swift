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



}
