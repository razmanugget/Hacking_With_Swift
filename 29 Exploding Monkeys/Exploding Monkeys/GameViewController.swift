//
//  GameViewController.swift
//  Exploding Monkeys
//
//  Created by home on 6/13/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

// MARK: - Enums | Extensions


class GameViewController: UIViewController {
  // MARK: - Variables
  var currentGame: GameScene!
  
  @IBOutlet weak var angleSlider: UISlider!
  @IBOutlet weak var angleLabel: UILabel!
  @IBOutlet weak var velocitySlider: UISlider!
  @IBOutlet weak var velocityLabel: UILabel!
  @IBOutlet weak var launchButton: UIButton!
  @IBOutlet weak var playerNumber: UILabel!
  
  // MARK: - IBActions
  @IBAction func angleChanged(_ sender: Any) {
    angleLabel.text = "Angle: \(Int(angleSlider.value))°"
  }
  @IBAction func velocityChanged(_ sender: Any) {
    velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
  }
  @IBAction func launch(_ sender: Any) {
    angleSlider.isHidden = true
    angleLabel.isHidden = true
    velocitySlider.isHidden = true
    velocityLabel.isHidden = true
    launchButton.isHidden = true
    
    currentGame.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
  }
  
  
  // MARK: - Functions
  func activatePlayer(number: Int) {
    if number == 1 {
      playerNumber.text = "<<< Player One"
    } else {
      playerNumber.text = "<<< Player Two"
    }
    
    angleSlider.isHidden = false
    angleLabel.isHidden = false
    velocitySlider.isHidden = false
    velocityLabel.isHidden = false
    launchButton.isHidden = false
  }
  
  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    
    angleChanged(angleSlider)
    velocityChanged(velocitySlider)
    
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      if let scene = SKScene(fileNamed: "GameScene") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        view.presentScene(scene)
        currentGame = scene as? GameScene
        currentGame.viewController = self
      }
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
