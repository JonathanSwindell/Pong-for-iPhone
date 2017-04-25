//
//  GameOverScreen.swift
//  Ultmate Pong
//
//  Created by Jonathan Swindell on 3/13/17.
//  Copyright © 2017 BlueTomCat. All rights reserved.
//

import SpriteKit

class GameOverScreen: SKScene {

        var ResultLabel:SKLabelNode!
        var ResultsButton:SKSpriteNode!
        var ThemesButton:SKSpriteNode!
        var StoreButton:SKSpriteNode!
    
    func showAdNow() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadAd"), object: nil)
    }
    override func didMove(to view: SKView) {
        var DicideInpulseDirection = Int(arc4random_uniform(UInt32(2))) + 1
        
        switch(DicideInpulseDirection){
        case 1:
            showAdNow()
        case 2: break
        default:
            showAdNow()
        }
        
        ResultsButton = self.childNode(withName: "returnButton") as! SKSpriteNode
        ResultLabel = self.childNode(withName: "results") as! SKLabelNode
        switch GameScene.whoWon {
        case 0:
            ResultLabel.text = "You Won"
        case 1:
            ResultLabel.text = "You Lost"
        case 2:
            ResultLabel.text = "Top Player Won"
        case 3:
            ResultLabel.text = "Bottom Player Won"
        default:
            ResultLabel.text = "You Won"
        }
    
   
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "returnButton"{
                let menuScene = MenuScreen(fileNamed: "MenuScreen")
                menuScene?.scaleMode = .aspectFill
                self.scene?.view?.presentScene(menuScene!)
            }
        }
    }

}
