//
//  GameScene.swift
//  Pachinko
//
//  Created by Tom Holland on 5/13/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        
        setBackground()
        setScoreLabel()
        setPhysics()
        
        addSlots()
        addBouncers()
    }
    
    func setPhysics() {
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
    }
    
    func setScoreLabel() {
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        
        addChild(scoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            let ball = SKSpriteNode(imageNamed: "ballRed")
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
            ball.physicsBody!.restitution = 0.4
            ball.position = location
            ball.zPosition = 101
            ball.name = "ball"
            
            addChild(ball)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            
            colisionBetween(ball: nodeA, object: nodeB)
            
        } else if nodeB.name == "ball" {
            
            colisionBetween(ball: nodeB, object: nodeA)
        }
    }
    
    func colisionBetween(ball: SKNode, object: SKNode) {
        
        guard let name = object.name else { return }
        
        switch name {
            
        case "good":
            destroy(ball: ball)
            
        case "bad":
            destroy(ball: ball)
            
        default:
            return
        }
    }
    
    func destroy(ball: SKNode) {
        ball.removeFromParent()
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        
        let spin = SKAction.rotate(byAngle: CGFloat.pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        switch isGood {
            
        case true:
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
            
        case false:
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody!.isDynamic = false
        
        slotGlow.position = position
        
        addChild(slotBase)
        addChild(slotGlow)
        
        slotGlow.run(spinForever)
    }
    
    func addSlots() {
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
    }
    
    func makeBouncer(at position: CGPoint) {
        
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody!.contactTestBitMask = bouncer.physicsBody!.collisionBitMask
        bouncer.physicsBody!.isDynamic = false
        bouncer.zPosition = 100
        
        addChild(bouncer)
    }
    
    func addBouncers() {
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
    }
    
    func setBackground() {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        
        background.position = CGPoint(x: 521, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        
        addChild(background)
    }
}
