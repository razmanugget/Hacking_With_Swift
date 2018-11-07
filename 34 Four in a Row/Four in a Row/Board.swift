//
//  Board.swift
//  Four in a Row
//
//  Created by home on 6/19/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import GameplayKit

// MARK: - Enums | Extensions
enum ChipColor: Int {
  case none = 0
  case red
  case black
}


class Board: NSObject, GKGameModel {
  // MARK: - Variables
  static var width = 7
  static var height = 6
  var slots = [ChipColor]()
  
  var currentPlayer: Player
  var players: [GKGameModelPlayer]? {
    return Player.allPlayers
  }
  var activePlayer: GKGameModelPlayer? {
    return currentPlayer
  }
  
  override init() {
    currentPlayer = Player.allPlayers[0]
    
    for _ in 0 ..< Board.width * Board.height {
      slots.append(.none)
    }
    super.init()
  }
  
  
  // MARK: - IBActions
  
  // MARK: - Functions
  func chip(inColumn column: Int, row: Int) -> ChipColor {
    return slots[row + column * Board.height]
  }
  
  
  func set(chip: ChipColor, in column: Int, row: Int) {
    slots[row + column * Board.height] = chip
  }
  
  
  func nextEmptySlot(in column: Int) -> Int? {
    for row in 0 ..< Board.height {
      if chip(inColumn: column, row: row) == .none {
        return row
      }
    }
    return nil
  }
  
  
  func canMove(in column: Int) -> Bool {
    return nextEmptySlot(in: column) != nil
  }
  
  
  func add(chip: ChipColor, in column: Int) {
    if let row = nextEmptySlot(in: column) {
      set(chip: chip, in: column, row: row)
    }
  }
  
  
  func isFull() -> Bool {
    for column in 0 ..< Board.width {
      if canMove(in: column) {
        return false
      }
    }
    return true
  }
  
  
  func isWin(for player: GKGameModelPlayer) -> Bool {
    let chip = (player as! Player).chip
    
    for row in 0 ..< Board.height {
      for col in 0 ..< Board.width {
        if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 0) {
          return true
        } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 0, moveY: 1) {
          return true
        } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 1) {
          return true
        } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: -1) {
          return true
        }
      }
    }
    return false
  }
  
  
  func squaresMatch(initialChip: ChipColor, row: Int, col: Int, moveX: Int, moveY: Int) -> Bool {
    // bail out early if we can't win from here
    if row + (moveY * 3) < 0 { return false }
    if row + (moveY * 3) >= Board.height { return false }
    if col + (moveX * 3) < 0 { return false }
    if col + (moveX * 3) >= Board.width { return false }
    
    // still here? check every square
    if chip(inColumn: col, row: row) != initialChip { return false }
    if chip(inColumn: col + moveX, row: row + moveY) != initialChip { return false }
    if chip(inColumn: col + (moveX * 2), row: row + (moveY * 2)) != initialChip { return false }
    if chip(inColumn: col + (moveX * 3), row: row + (moveY * 3)) != initialChip { return false }
    
    return true
  }
  
  
  func copy(with zone: NSZone? = nil) -> Any {
    let copy = Board()
    copy.setGameModel(self)
    return copy
  }
  
  
  func setGameModel(_ gameModel: GKGameModel) {
    if let board = gameModel as? Board {
      slots = board.slots
      currentPlayer = board.currentPlayer
    }
  }
  
  
  func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
    // downcast into a player object
    if let playerObject = player as? Player {
      // if a winner, return nil to stop moves
      if isWin(for: playerObject) || isWin(for: playerObject.opponent) {
        return nil
      }
      // else create new array that holds move objects
      var moves = [Move]()
      
      // loop thru columns to determine if a player can move
      for column in 0 ..< Board.width {
        if canMove(in: column) {
          // if yes for move, create a new move object for that col and add to array
          moves.append(Move(column: column))
        }
      }
      // return the array to tell AI all possible moves
      return moves
    }
    return nil
  }
  
  
  func apply(_ gameModelUpdate: GKGameModelUpdate) {
    if let move = gameModelUpdate as? Move {
      add(chip: currentPlayer.chip, in: move.column)
      currentPlayer = currentPlayer.opponent
    }
  }
  
  
  func score(for player: GKGameModelPlayer) -> Int {
    if let playerObject = player as? Player {
      if isWin(for: playerObject) {
        return 1000
      } else if isWin(for: playerObject.opponent) {
        return -1000
      }
    }
    return 0
  }
  
  
  // MARK: - Override Functions
  
  
  
  
  
  
  
  
  
  
  
  
}
