//
//  CircleButton.swift
//  Calculator
//
//  Created by sangho Cho on 2021/05/10.
//

import Foundation
import UIKit

class CircleButton: UIButton {
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.bounds.height / 2
  }

}
