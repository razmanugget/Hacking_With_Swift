//
//  Move.swift
//  Four in a Row
//
//  Created by home on 6/20/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import GameplayKit


class Move: NSObject, GKGameModelUpdate {
  var value: Int = 0
  var column: Int
  
  init(column: Int) {
    self.column = column
  }
}
