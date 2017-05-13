//
//  GameScene.swift
//  Pachinko
//
//  Created by Tom Holland on 5/13/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        setBackground()
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        addSlots()
        addBouncers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            let ball = SKSpriteNode(imageNamed: "ballRed")
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            ball.physicsBody!.restitution = 0.4
            ball.position = location
            
            addChild(ball)
        }
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        
        var slotBase: SKSpriteNode
        
        switch isGood {
            
            case true:
                slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            
            case false:
                slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
        }
        
        slotBase.position = position
        
        addChild(slotBase)
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
        bouncer.physicsBody!.isDynamic = false
        
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
