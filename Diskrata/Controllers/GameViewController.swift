//
//  GameViewController.swift
//  Diskrata
//
//  Created by William Inx on 05/08/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        let scene = GameScene(size: view.frame.size)
        skView.showsFPS = true
        scene.scaleMode = .resizeFill
        
        skView.presentScene(scene)
        

    }
}
