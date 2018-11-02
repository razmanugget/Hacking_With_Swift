//
//  GameScene.swift
//  Fireworks
//
//  Created by home on 5/25/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import SpriteKit
import GameplayKit
// git test

class GameScene: SKScene {
  // MARK: - Variables
  var gameTimer: Timer!
  var fireworks = [SKNode]()
  
  let leftEdge = -22
  let bottomEdge = -22
  let rightEdge = 1024 + 22
  
  var gameScore: SKLabelNode!
  var score = 0 {
    didSet {
      gameScore.text = "Score: \(score)"
    }
  }
  
  
  // MARK: - Functions
  func createScore() {
    gameScore = SKLabelNode(fontNamed: "Chalkduster")
    gameScore.text = "Score: 0"
    gameScore.horizontalAlignmentMode = .left
    gameScore.fontSize = 48
    addChild(gameScore)
    gameScore.position = CGPoint(x: 8, y: 8)
  }
  
  func createFirework(xMovement: CGFloat, x: Int, y: Int) {
    // SKNode acts as firework container and position
    let node = SKNode()
    node.position = CGPoint(x: x, y: y)
    // create rocket sprite node
    let firework = SKSpriteNode(imageNamed: "rocket")
    firework.colorBlendFactor = 1
    firework.name = "firework"
    node.addChild(firework)
    // firework sprite node gets 1 of 3 randome colors
    switch GKRandomSource.sharedRandom().nextInt(upperBound: 3) {
    case 0:
      firework.color = .cyan
    case 1:
      firework.color = .green
    case 2:
      firework.color = .yellow
    default:
      break
    }
    // create UIBezierPath for movement
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: xMovement, y: 1000))
    // tell container to follow the path
    let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
    node.run(move)
    // create firework particles
    let emitter = SKEmitterNode(fileNamed: "fuse")!
    emitter.position = CGPoint(x: 0, y: -22)
    node.addChild(emitter)
    // add firework to fireworks array/scene
    fireworks.append(node)
    addChild(node)
  }
  
  @objc func launchFireworks() {
    let movementAmount: CGFloat = 1800
    
    switch GKRandomSource.sharedRandom().nextInt(upperBound: 4) {
    case 0:
      // fire five, straight up
      createFirework(xMovement: 0, x: 512, y: bottomEdge)
      createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
      createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
      createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
      createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)
    case 1:
      // fire five, in a fan
      createFirework(xMovement: 0, x: 512, y: bottomEdge)
      createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
      createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
      createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
      createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)
    case 2:
      // fire five, from the left to the right
      createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
      createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
      createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
      createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
      createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)
    case 3:
      // fire five, from the right to the left
      createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
      createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
      createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
      createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
      createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)
    default:
      break
    }
  }
  
  func checkTouches(_ touches: Set<UITouch>) {
    guard let touch = touches.first else { return }
    
    let location = touch.location(in: self)
    let nodesAtPoint = nodes(at: location)
    
    for node in nodesAtPoint {
      if node is SKSpriteNode {
        let sprite = node as! SKSpriteNode
        if sprite.name == "firework" {
          for parent in fireworks {
            let firework = parent.children[0] as! SKSpriteNode
            if firework.name == "selected" && firework.color != sprite.color {
              firework.name = "firework"
              firework.colorBlendFactor = 1
            }
          }
          sprite.name = "selected"
          sprite.colorBlendFactor = 0
        }
      }
    }
  }
  
  func explode(firework: SKNode) {
    let emitter = SKEmitterNode(fileNamed: "explode")!
    emitter.position = firework.position
    addChild(emitter)
    
    firework.removeFromParent()
  }
  
  func explodeFireworks() {
    var numExploded = 0
    
    for (index, fireworkContainer) in fireworks.enumerated().reversed() {
      let firework = fireworkContainer.children[0] as! SKSpriteNode
      
      if firework.name == "selected" {
        // destoy this firework!
        explode(firework: fireworkContainer)
        fireworks.remove(at: index)
        numExploded += 1
      }
    }
    
    switch numExploded {
    case 0:
      // nothing
      break
    case 1:
      score += 200
    case 2:
      score += 500
    case 3:
      score += 1500
    case 4:
      score += 2500
    default:
      score += 4000
    }
  }
  
  
  // MARK: - Override Functions
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)
    
    createScore()
    
    gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    checkTouches(touches)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    checkTouches(touches)
  }
  
  override func update(_ currentTime: TimeInterval) {
    for (index, firework) in fireworks.enumerated().reversed() {
      if firework.position.y > 900 {
        // this uses a position high above so that rockets can explode off screen
        fireworks.remove(at: index)
        firework.removeFromParent()
      }
    }
  }
  
}
