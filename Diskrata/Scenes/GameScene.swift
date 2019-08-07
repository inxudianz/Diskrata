//
//  GameScene.swift
//  Diskrata
//
//  Created by William Inx on 05/08/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let spaceShip = SKSpriteNode(imageNamed: "spaceShip")
    
    override func didMove(to view: SKView) {
        spaceShip.position = CGPoint(x: frame.maxX/2, y: frame.minY)
        addChild(spaceShip)
        
    }
}
