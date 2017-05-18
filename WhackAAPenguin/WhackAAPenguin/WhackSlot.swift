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
    var isVisible = false
    var isHit = false
    
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
    
    func show(hideTime: Double) {
        
        guard !isVisible else { return }
        
        characterNode.xScale = 1
        characterNode.yScale = 1
        
        characterNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        switch RandomInt(min: 0, max: 2) {
        case 0:
            characterNode.texture = SKTexture(imageNamed: "penguinGood")
            characterNode.name = "characterFriend"
        default:
            characterNode.texture = SKTexture(imageNamed: "penguinEvil")
            characterNode.name = "characterEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [unowned self] in
            
            self.hide()
        }
    }
    
    func hide() {
        
        guard isVisible else { return }
        
        characterNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run { [unowned self] in
            
            self.isVisible = false
        }
        
        characterNode.run(SKAction.sequence([delay, hide, notVisible]))
    }
}
