//
//  GameScene.swift
//  WhackAAPenguin
//
//  Created by Tom Holland on 5/17/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var slots = [WhackSlot]()
    var gameScore: SKLabelNode!
    var popUpTime = 0.85
    
    var score: Int = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            self.createEnemy()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        onFirstTouch(with: touches)
    }
    
    func onFirstTouch(with touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        
        
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            
            guard let name = node.name else { return }
            guard let parent = node.parent?.parent else { return }
            
            switch name {
                
            case "characterFriend":
                friend(ofParentWasHit: parent)
                
            case "characterEnemy":
                enemy(ofParentWasHit: parent)
    
            default:
                return
            }
        }
    }
    
    
    func friend(ofParentWasHit parent: SKNode) {
        let whackedSlot = parent as! WhackSlot
        
        guard whackedSlot.isVisible && !whackedSlot.isHit else { return }
        
        whackedSlot.hit()
        
        score -= 5
        
        run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
    }
    
    func enemy(ofParentWasHit parent: SKNode) {
        
        let whackedSlot = parent as! WhackSlot
        
        guard whackedSlot.isVisible && !whackedSlot.isHit else { return }
        
        whackedSlot.characterNode.xScale = 0.85
        whackedSlot.characterNode.yScale = 0.85
        
        whackedSlot.hit()
        score += 1
        
        run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
    }
    
    func createSlot(at position: CGPoint){
        
        let slot = WhackSlot()
        
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    func createEnemy() {
        popUpTime *= 0.991
        slots = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: slots) as! [WhackSlot]
        slots[0].show(hideTime: popUpTime)
        
        if RandomInt(min: 0, max: 12) > 4 { slots[1].show(hideTime: popUpTime) }
        if RandomInt(min: 0, max: 12) > 8 { slots[2].show(hideTime: popUpTime) }
        if RandomInt(min: 0, max: 12) > 10 { slots[3].show(hideTime: popUpTime) }
        if RandomInt(min: 0, max: 12) > 11 { slots[4].show(hideTime: popUpTime) }
        
        let minDelay = popUpTime / 2.0
        let maxDelay = popUpTime * 2
        let delay = RandomDouble(min: minDelay, max: maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            self.createEnemy()
        }
    }
}
