//
//  MenuScreen.swift
//  Ultmate Pong
//
//  Created by Jonathan Swindell on 2/27/17.
//  Copyright © 2017 BlueTomCat. All rights reserved.
//

import SpriteKit

class MenuScreen: SKScene {
    var newGameButton:SKSpriteNode!
    var difficultyButton:SKSpriteNode!
    var DifficultyLabel:SKLabelNode!
    
    override func didMove(to view: SKView) {
        newGameButton = self.childNode(withName: "newGameButton") as! SKSpriteNode
        difficultyButton = self.childNode(withName: "difficultyButton") as! SKSpriteNode
        DifficultyLabel = self.childNode(withName: "difficultyLabel") as! SKLabelNode

        
        newGameButton.texture = SKTexture(imageNamed: "NewGameButton")
        difficultyButton.texture = SKTexture(imageNamed: "ChangeDifficultyButton")

        let userDefaults = UserDefaults.standard
        
        if (userDefaults.integer(forKey: "Mode")==0){
            DifficultyLabel.text = "Easy"
        }else if(userDefaults.integer(forKey: "Mode")==1){
            DifficultyLabel.text = "Medium"
        }else if(userDefaults.integer(forKey: "Mode")==2){
            DifficultyLabel.text = "Hard"
        }else if(userDefaults.integer(forKey: "Mode")==3){
            DifficultyLabel.text = "2 Players"
        }else{
            DifficultyLabel.text = "Easy"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "newGameButton"{
                let gameScene = GameScene(fileNamed: "GameScene")
                self.scene?.view?.presentScene(gameScene!)
            }
            if nodesArray.first?.name == "difficultyButton"{
                let ButtonTapSound = SKAction.playSoundFileNamed("Selection",waitForCompletion: false)
                run(ButtonTapSound)
                changeDifficulty()
            }
        }
    }
  
    
    func changeDifficulty(){
        let userDefaults = UserDefaults.standard
        if  (DifficultyLabel.text == "Easy"){
            DifficultyLabel.text = "Medium"
            userDefaults.set(1, forKey: "Mode")
        }else if(DifficultyLabel.text == "Medium"){
            DifficultyLabel.text = "Hard"
            userDefaults.set(2, forKey: "Mode")
        }else if(DifficultyLabel.text == "Hard"){
            DifficultyLabel.text = "2 Players"
            userDefaults.set(3, forKey: "Mode")
        }else if(DifficultyLabel.text == "2 Players"){
            DifficultyLabel.text = "Easy"
            userDefaults.set(0, forKey: "Mode")
        }
        userDefaults.synchronize()
    }
}
