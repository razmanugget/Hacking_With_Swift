//
//  ViewController.swift
//  Four in a Row
//
//  Created by home on 6/18/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import GameplayKit


class ViewController: UIViewController {
  // MARK: - Variables
  var placedChips = [[UIView]]()
  var board: Board!
  var strategist: GKMinmaxStrategist!

  @IBOutlet var columnButtons: [UIButton]!
  
  
  // MARK: - IBActions
  @IBAction func makeMove(_ sender: UIButton) {
    let column = sender.tag
    if let row = board.nextEmptySlot(in: column) {
      board.add(chip: board.currentPlayer.chip, in: column)
      addChip(inColumn: column, row: row, color: board.currentPlayer.color)
      continueGame()
    }
  }
  
  
  
  // MARK: - Functions
  func resetBoard() {
    board = Board()
    strategist.gameModel = board
    
    updateUI()
    
    for i in 0 ..< placedChips.count {
      for chip in placedChips[i] {
        chip.removeFromSuperview()
      }
      placedChips[i].removeAll(keepingCapacity: true)
    }
  }
  
  
  func addChip(inColumn column: Int, row: Int, color: UIColor) {
    let button = columnButtons[column]
    let size = min(button.frame.width, button.frame.height / 6)
    let rect = CGRect(x: 0, y: 0, width: size, height: size)
    
    if (placedChips[column].count < row + 1) {
      let newChip = UIView()
      newChip.frame = rect
      newChip.isUserInteractionEnabled = false
      newChip.backgroundColor = color
      newChip.layer.cornerRadius = size / 2
      newChip.center = positionForChip(inColumn: column, row: row)
      newChip.transform = CGAffineTransform(translationX: 0, y: -800)
      view.addSubview(newChip)
      UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
        newChip.transform = CGAffineTransform.identity
      })
      
      placedChips[column].append(newChip)
    }
  }
  
  
  func positionForChip(inColumn column: Int, row: Int) -> CGPoint {
    let button = columnButtons[column]
    let size = min(button.frame.width, button.frame.height / 6)
    
    let xOffset = button.frame.midX
    var yOffset = button.frame.maxY - size / 2
    yOffset -= size * CGFloat(row)
    
    return CGPoint(x: xOffset, y: yOffset)
  }
  
  
  func updateUI() {
    title = "\(board.currentPlayer.name)'s Turn"
    
    if board.currentPlayer.chip == .black {
      startAIMove()
    }
  }
  
  
  func continueGame() {
    // title set to nil
    var gameOverTitle: String? = nil
    
    // update game status if over or full
    if board.isWin(for: board.currentPlayer)
    {
      gameOverTitle = "\(board.currentPlayer.name) Wins!"
    } else if board.isFull() {
      gameOverTitle = "Draw!"
    }
    // if title is not nil, show an alert to reset
    if gameOverTitle != nil {
      let alert = UIAlertController(title: gameOverTitle, message: nil, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "Play Again", style: .default) { [unowned self] (action) in
        self.resetBoard()
      }
      alert.addAction(alertAction)
      present(alert, animated: true)
      
      return
    }
    // otherwise change current player
    board.currentPlayer = board.currentPlayer.opponent
    updateUI()
  }
  
  
  func columnForAIMove() -> Int? {
    if let aiMove = strategist.bestMove(for: board.currentPlayer) as? Move {
      return aiMove.column
    }
    return nil
  }
  
  
  func makeAIMove(in column: Int) {
    columnButtons.forEach{ $0.isEnabled = true }
    navigationItem.leftBarButtonItem = nil
    
    if let row = board.nextEmptySlot(in: column) {
      board.add(chip: board.currentPlayer.chip, in: column)
      addChip(inColumn: column, row: row, color: board.currentPlayer.color)
      
      continueGame()
    }
  }
  
  
  func startAIMove() {
    // forEach = closure executing code on each item in array
    columnButtons.forEach { $0.isEnabled = false }
    let spinner = UIActivityIndicatorView(style: .gray)
    spinner.startAnimating()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: spinner)
    
    DispatchQueue.global().async { [unowned self] in
      let strategistTime = CFAbsoluteTimeGetCurrent()
      guard let column = self.columnForAIMove() else { return }
      let delta = CFAbsoluteTimeGetCurrent() - strategistTime
      
      let aiTimeCeiling = 1.0
      let delay = aiTimeCeiling - delta
      
      DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        self.makeAIMove(in: column)
      }
    }
  }
  
  
  
  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    
    strategist = GKMinmaxStrategist()
    strategist.maxLookAheadDepth = 7
    strategist.randomSource = nil
    
    for _ in 0 ..< Board.width {
      placedChips.append([UIView]())
    }
    resetBoard()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

