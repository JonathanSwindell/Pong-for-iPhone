//
//  GameOverScreen.swift
//  Ultmate Pong
//
//  Created by Jonathan Swindell on 3/13/17.
//  Copyright © 2017 BlueTomCat. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameOverScreen: SKScene {

        var ResultLabel:SKLabelNode!
        var ResultsButton:SKSpriteNode!
        var ThemesButton:SKSpriteNode!
        var StoreButton:SKSpriteNode!
        var soundEffectPlayer = AVAudioPlayer()
    
        override func didMove(to view: SKView) {
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
                playSoundEffect()
                let menuScene = MenuScreen(fileNamed: "MenuScreen")
                menuScene?.scaleMode = .aspectFill
                self.scene?.view?.presentScene(menuScene!)
            }
        }
    }
    
    func playSoundEffect() {
        // Set the sound file name & extension
        let path = Bundle.main.path(forResource: "Selection.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
            soundEffectPlayer.play()
        } catch {
            print("there is \(error)")
        }
    }
}
