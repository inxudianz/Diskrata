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
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addEnemy),SKAction.wait(forDuration: 1.0)])))
    }
    
    func random() -> CGFloat {
        return CGFloat.random(in: 0...1)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addEnemy() {
        let enemy = SKSpriteNode(imageNamed: "enemy")
        
        let spawnPointX = random(min: enemy.size.width/2 , max: size.width - enemy.size.width/2)
        
        print(random())
        enemy.position = CGPoint(x: spawnPointX , y: size.height + enemy.size.height/2)
        
        addChild(enemy)
        
        let enemySpeed = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        let moveAction = SKAction.move(to: CGPoint(x: spawnPointX , y: -enemy.size.width/2), duration: TimeInterval(enemySpeed))
        let moveActionDone = SKAction.removeFromParent()
        enemy.run(SKAction.sequence([moveAction,moveActionDone]))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let projectile = SKSpriteNode(imageNamed: "laser")
        projectile.position = spaceShip.position
        
        addChild(projectile)
        
        let destination = spaceShip.position + CGPoint(x: 0, y: spaceShip.position.y + 1000)
        
 
        let actionMove = SKAction.move(to: destination, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
}
