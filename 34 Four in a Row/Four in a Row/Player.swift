//
//  Player.swift
//  Four in a Row
//
//  Created by home on 6/19/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import GameplayKit

class Player: NSObject, GKGameModelPlayer {
  var chip: ChipColor
  var color: UIColor
  var name: String
  var playerId: Int
  var opponent: Player {
    if chip == .red {
      return Player.allPlayers[1]
    } else {
      return Player.allPlayers[0]
    }
  }
  
  static var allPlayers = [Player(chip: .red), Player(chip: .black)]
  
  init(chip: ChipColor) {
    self.chip = chip
    self.playerId = chip.rawValue
    
    if chip == .red {
      color = .red
      name = "Red"
    } else {
      color = .black
      name = "Black"
    }
    super.init()
  }
  
  
  
}
