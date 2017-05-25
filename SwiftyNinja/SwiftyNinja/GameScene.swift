//
//  GameScene.swift
//  SwiftyNinja
//
//  Created by Tom Holland on 5/24/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import SpriteKit
import GameplayKit

enum ForceBomb {
    case never, always, random
}

class GameScene: SKScene {
    
    var gameScore: SKLabelNode!
    var score: Int = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    var livesImages = [SKSpriteNode]()
    var lives = 3
    
    var activeSliceBG: SKShapeNode!
    var activeSliceFG: SKShapeNode!
    var activeSlicePoints = [CGPoint]()
    var swooshSoundIsActive = false
    var activeEnemies = [SKSpriteNode]()
    
    
    override func didMove(to view: SKView) {
        
        setBackground()
        setPhysics()
        
        createScore()
        createLives()
        createSlices()
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        activeSlicePoints.removeAll(keepingCapacity: true)
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        
        redrawActiveSlice()
        
        activeSliceBG.removeAllActions()
        activeSliceFG.removeAllActions()
        
        activeSliceBG.alpha = 1
        activeSliceFG.alpha = 1
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        
        let location = touch.location(in: self)
        
        activeSlicePoints.append(location)
        redrawActiveSlice()
        
        if !swooshSoundIsActive {
            playSwooshSound()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeSliceBG.run(SKAction.fadeOut(withDuration: 0.25))
        activeSliceFG.run(SKAction.fadeOut(withDuration: 0.25))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    func redrawActiveSlice() {
        
        if activeSlicePoints.count < 2 {
            activeSliceBG.path = nil
            activeSliceFG.path = nil
        }
        
        while activeSlicePoints.count > 12 {
            activeSlicePoints.remove(at: 0)
        }
        
        let path = UIBezierPath()
        path.move(to: activeSlicePoints[0])
        
        for i in 1 ..< activeSlicePoints.count {
            path.addLine(to: activeSlicePoints[i])
        }
        
        activeSliceBG.path = path.cgPath
        activeSliceFG.path = path.cgPath
        
    }
    
    func createScore() {
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        gameScore.position = CGPoint(x: 8, y: 8)
        
        addChild(gameScore)
    }
    
    func createLives() {
        for i in 0 ..< 3 {
            let spriteNode = SKSpriteNode(imageNamed: "sliceLife")
            spriteNode.position = CGPoint(x: CGFloat(834 + (i * 70)), y: 720)
            
            addChild(spriteNode)
            
            livesImages.append(spriteNode)
        }
    }
    
    func createSlices() {
        activeSliceBG = SKShapeNode()
        activeSliceBG.zPosition = 2
        activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
        activeSliceBG.lineWidth = 9
        
        activeSliceFG = SKShapeNode()
        activeSliceFG.zPosition = 2
        activeSliceFG.strokeColor = UIColor.white
        activeSliceFG.lineWidth = 5
        
        addChild(activeSliceBG)
        addChild(activeSliceFG)
    }
    
    func setBackground() {
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
    }
    
    func setPhysics() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.speed = 0.85
    }
    
    func playSwooshSound() {
        swooshSoundIsActive = true
        
        let randomNumber = RandomInt(min: 1, max: 3)
        let soundName = "swoosh\(randomNumber).caf"
        let swooshSound = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
        
        run(swooshSound) { [unowned self] in
            self.swooshSoundIsActive = false
        }
        
    }
    
    func createEnemy(forceBomb: ForceBomb = .random) {
        
        var enemy: SKSpriteNode!
        var enemyType = RandomInt(min: 0, max: 6)
        
        
        switch forceBomb {
        case .never:
            enemyType = 1
        case .always:
            enemyType = 0
        default:
            break
        }
        
        switch enemyType {
        case 0: break
            // bomb
        default:
            enemy = SKSpriteNode(imageNamed: "penguin")
            run(SKAction.playSoundFileNamed("launch.caf", waitForCompletion: false))
            enemy.name = "enemy"
            
        }
        
        
        // Give enemy a random position
        let randomPosition = CGPoint(x: RandomInt(min: 64, max: 960), y: -128)
        enemy.position = randomPosition
        
        // Create a random angular velocity
        let randomAngularVelocity = CGFloat(RandomInt(min: -6, max: 6)) / 2.0
        
        // Create a random x velocity
        var randomXVelocity = 0
        
        switch randomPosition {
        case let position where position.x < 256:
            randomXVelocity = RandomInt(min: 8, max: 15)
        case let position where position.x < 512:
            randomXVelocity = RandomInt(min: 3, max: 5)
        case let position where position.x < 768:
            randomXVelocity = -RandomInt(min: 3, max: 5)
        default:
            randomXVelocity = -RandomInt(min: 8, max: 15)
        }
        
        // Create a random y velocity
        let randomYVelocity = RandomInt(min: 24, max: 32)
        
        // Assign circular physics to enemy
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 64)
        
        guard enemy.physicsBody != nil else { return }
        
        enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * 40, dy: randomYVelocity * 40)
        enemy.physicsBody?.angularVelocity = randomAngularVelocity
        enemy.physicsBody?.collisionBitMask = 0
        
        
        addChild(enemy)
        activeEnemies.append(enemy)
        
    }
}
