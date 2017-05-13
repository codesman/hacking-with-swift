//
//  GameScene.swift
//  Pachinko
//
//  Created by Tom Holland on 5/13/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    var editMode: Bool = false {
        
        didSet {
            
            switch editMode {
                
            case true:
                editLabel.text = "Done"
                
            case false:
                editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        setBackground()
        setScoreLabel()
        setEditLabel()
        setPhysics()
        
        addSlots()
        addBouncers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        onFirstTouch(handle: touches)
    }
    
    func onFirstTouch(handle touches: Set<UITouch>) {
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        switch objects.contains(editLabel) {
            
        case true:
            editMode = !editMode
            
        case false:
            makeItem(at: location)
        }
    }
    
    func makeItem(at location: CGPoint){
        
        switch editMode {
            
        case true:
            makeBox(at: location)
            
        case false:
            makeBall(at: location)
        }
        
    }
    
    func makeBox(at location: CGPoint) {
        
        let size = CGSize(width: GKRandomDistribution(lowestValue: 16, highestValue: 128).nextInt(), height: 16)
        let box = SKSpriteNode(color: RandomColor(), size: size)
        
        box.zRotation = RandomCGFloat(min: 0, max: 3)
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody!.isDynamic = false
        
        addChild(box)
    }
    
    func makeBall(at location: CGPoint) {
        
        let ball = SKSpriteNode(imageNamed: "ballRed")
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.physicsBody!.restitution = 0.4
        ball.position = constrainY(of: location)
        ball.zPosition = 101
        ball.name = "ball"
        
        addChild(ball)
    }
    
    func constrainY(of location: CGPoint) -> CGPoint{
        
        return CGPoint(x: location.x, y: 720)
    }
    
    func setEditLabel() {
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        
        addChild(editLabel)
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
            score += 1
            
        case "bad":
            destroy(ball: ball)
            score -= 1
            
        default:
            return
        }
    }
    
    func destroy(ball: SKNode) {
        
        guard let fireParticles = SKEmitterNode(fileNamed: "FireParticles") else { return }
        
        fireParticles.position = ball.position
        fireParticles.zPosition = 102
        
        addChild(fireParticles)
        
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
