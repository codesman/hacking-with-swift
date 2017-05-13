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
        
        let background = SKSpriteNode(imageNamed: "background.jpg")
        
        background.position = CGPoint(x: 521, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
            
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
            box.position = location
            
            addChild(box)
        }
        
    }
    
}
