//
//  WhackSlot.swift
//  WhackAAPenguin
//
//  Created by Tom Holland on 5/17/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit
import SpriteKit

class WhackSlot: SKSpriteNode {

    var characterNode: SKSpriteNode!
    
    func configure(at position: CGPoint) {
        
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        characterNode = SKSpriteNode(imageNamed: "penguinGood")
        characterNode.position = CGPoint(x: 0, y: -90)
        characterNode.name = "character"
        cropNode.addChild(characterNode)
        
        addChild(cropNode)
    }
}
