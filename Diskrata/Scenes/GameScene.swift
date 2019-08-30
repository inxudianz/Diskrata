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
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
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
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.enemy
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
        enemy.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let spawnPointX = random(min: enemy.size.width/2 , max: size.width - enemy.size.width/2)

        enemy.position = CGPoint(x: spawnPointX , y: size.height + enemy.size.height/2)
        
        addChild(enemy)
        
        let enemySpeed = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        let moveAction = SKAction.move(to: CGPoint(x: spawnPointX , y: -enemy.size.width/2), duration: TimeInterval(enemySpeed))
        let moveActionDone = SKAction.removeFromParent()
        enemy.run(SKAction.sequence([moveAction,moveActionDone]))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if touchLocation.y > spaceShip.frame.maxY {
            print("Touch :\(touchLocation.y)")
            print("Space : \(spaceShip.position.y)")
            let projectile = SKSpriteNode(imageNamed: "laser")
            
            projectile.physicsBody = SKPhysicsBody(rectangleOf: projectile.size)
            projectile.physicsBody?.isDynamic = true
            projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
            projectile.physicsBody?.contactTestBitMask = PhysicsCategory.enemy
            projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
            projectile.physicsBody?.usesPreciseCollisionDetection = true
            
            projectile.position = spaceShip.position
            
            addChild(projectile)
            
            let destination = spaceShip.position + CGPoint(x: 0, y: spaceShip.position.y + 1000)
            
            
            let actionMove = SKAction.move(to: destination, duration: 2.0)
            let actionMoveDone = SKAction.removeFromParent()
            projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
        }
        else {
            let destination = CGPoint(x: touchLocation.x, y: spaceShip.position.y)
            
            let actionMove = SKAction.move(to: destination, duration: 0.5)
            spaceShip.run(SKAction.sequence([actionMove]))
        }
        
    }
    
    func projectileHit(projectile: SKSpriteNode, enemy: SKSpriteNode) {
        projectile.removeFromParent()
        enemy.removeFromParent()
    }
    
}

extension GameScene : SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.enemy != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
            if let enemy = firstBody.node as? SKSpriteNode,
                let projectile = secondBody.node as? SKSpriteNode {
                projectileHit(projectile: projectile, enemy: enemy)
            }
        }
    }
}
