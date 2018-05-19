//
//  MenuScreen.swift
//  Ultmate Pong
//
//  Created by Jonathan Swindell on 2/27/17.
//  Copyright © 2017 BlueTomCat. All rights reserved.
//

import SpriteKit

class MenuScreen: SKScene {
    //Variable declarations
    var newGameButton:SKSpriteNode!
    var difficultyButton:SKSpriteNode!
    var DifficultyLabel:SKLabelNode!
    var HighScoreLabel:SKLabelNode!
    
    //didMove is called when MenuSence is presented
    override func didMove(to view: SKView) {
        //seting up variables
        newGameButton = self.childNode(withName: "newGameButton") as! SKSpriteNode
        difficultyButton = self.childNode(withName: "difficultyButton") as! SKSpriteNode
        DifficultyLabel = self.childNode(withName: "difficultyLabel") as! SKLabelNode
        HighScoreLabel = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        newGameButton.texture = SKTexture(imageNamed: "NewGameButton")
        difficultyButton.texture = SKTexture(imageNamed: "ChangeDifficultyButton")
        let userDefaults = UserDefaults.standard
        
        //Makes the HighScoreLabel invisible
        HighScoreLabel.isHidden = true
        
        //Sets DifficultyLabel.text depending on the game mode
        if (userDefaults.integer(forKey: "Mode")==0){
            DifficultyLabel.text = "Easy"
        }else if(userDefaults.integer(forKey: "Mode")==1){
            DifficultyLabel.text = "Medium"
        }else if(userDefaults.integer(forKey: "Mode")==2){
            DifficultyLabel.text = "Hard"
        }else if(userDefaults.integer(forKey: "Mode")==3){
            DifficultyLabel.text = "2 Players"
        }else if(userDefaults.integer(forKey: "Mode")==4){
            DifficultyLabel.text = "Endless"
            //Sets high score to the current highscore
            HighScoreLabel.text = "High Score: " + String(userDefaults.integer(forKey: "HighScore"))
            //shows HighScoreLabel
            HighScoreLabel.isHidden = false
        }
        else{
            //defualt
            DifficultyLabel.text = "Easy"
        }
    }

    //Calls when screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        ///checks location of touch
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)//if the touch coordinate equal a button contenue
            if nodesArray.first?.name == "newGameButton"{
                //moves to gamescene
                let gameScene = GameScene(fileNamed: "GameScene")
                self.scene?.view?.presentScene(gameScene!)
            }
            if nodesArray.first?.name == "difficultyButton"{
                //plays tap sound and changes difficulty
                let ButtonTapSound = SKAction.playSoundFileNamed("Selection",waitForCompletion: false)
                run(ButtonTapSound)
                changeDifficulty()
            }
        }
    }
  
    
    func changeDifficulty(){
        let userDefaults = UserDefaults.standard
        //checks current gamemode and then changed DifficultyLabel.text and mode key
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
            DifficultyLabel.text = "Endless"
            HighScoreLabel.text = "High Score: " + String(userDefaults.integer(forKey: "HighScore"))
            HighScoreLabel.isHidden = false
            //shows HighScoreLabel
            userDefaults.set(4, forKey: "Mode")
        }
        else if(DifficultyLabel.text == "Endless"){
            //Hides HighScoreLabel
            HighScoreLabel.isHidden = true
            DifficultyLabel.text = "Easy"
            userDefaults.set(0, forKey: "Mode")
        }
        //saves userDefaults
        userDefaults.synchronize()
    }
}
