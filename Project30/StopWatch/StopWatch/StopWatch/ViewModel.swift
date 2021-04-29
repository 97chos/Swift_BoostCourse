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

  private var state: State = .stop
  private var lapCount = 1


  // MARK: Functions

  @objc func changeState() {
    
  }



}
