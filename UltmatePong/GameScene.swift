//  GameScene.swift
//  Ultmate Pong
//
//  Created by Jonathan Swindell on 2/26/17.
//  Copyright © 2017 BlueTomCat. All rights reserved.
//

import SpriteKit
import GameplayKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var currentGameType = gameType.easy
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
    var score = [Int]()
    static var whoWon = 0
    //single player
    //0 = You won
    //1 = opponent won
    //two player one device
    //2 = top player won
    //3 = button pleyer won
    let userDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        
        if (userDefaults.integer(forKey: "Mode")==0){
            currentGameType = gameType.easy
        }else if(userDefaults.integer(forKey: "Mode")==1){
            currentGameType = gameType.medium
        }else if(userDefaults.integer(forKey: "Mode")==2){
            currentGameType = gameType.hard
        }else if(userDefaults.integer(forKey: "Mode")==3){
            currentGameType = gameType.player2
        }
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        print(currentGameType)
        startGame()
    }
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        let DicideInpulseDirection = Int(arc4random_uniform(UInt32(4))) + 1
        let when = DispatchTime.now() + 1 // change 1 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            let timer = DispatchTime.now() + 0.5 // change 0.5 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: timer) {
                switch(DicideInpulseDirection){
                case 1:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: 375, dy: 375))
                case 2:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: -375, dy: -375))
                case 3:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: -375, dy: 375))
                case 4:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: 375, dy: -375))
                default:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: 375, dy: 375))
                }
                
            }
        }
    }
    
    func addScore(PlayerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x:0,y:0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let DicideInpulseDirection = Int(arc4random_uniform(UInt32(4))) + 1
        if PlayerWhoWon == main{
            score[0] += 1
            switch(DicideInpulseDirection){
            case 1:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: 375, dy: 375))
            case 2:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: -375, dy: -375))
            case 3:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: -375, dy: 375))
            case 4:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: 375, dy: -375))
            default:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: 375, dy: 375))
            }
        }else if PlayerWhoWon == enemy{
            score[1] += 1
            switch(DicideInpulseDirection){
            case 1:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: 375, dy: 375))
            case 2:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: -375, dy: -375))
            case 3:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: -375, dy: 375))
            case 4:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: 375, dy: -375))
            default:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: 375, dy: 375))
            }
            
        }
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.37))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player2{
                if location.y > 0{
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.37))
                }
                
                if location.y < 0{
                    main.run(SKAction.moveTo(x: location.x, duration: 0.37))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.37))
            }
            
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.1))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.8))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
            break
        case .player2:
            
            break
            
            
        }
        if ball.position.y > 0{
            ball.color = (UIColor.init(red: ball.position.y/255, green: 0, blue: 0, alpha: 1))
        }
        if ball.position.y < 0{
            ball.color = (UIColor.init(red: 0, green: 0, blue: ball.position.y/(-255), alpha: 1))
            //255 has to be negative because the ball's positon is negative.
        }
        
        
        if ball.position.y <= main.position.y - 30{
            addScore(PlayerWhoWon: enemy)
        }else if ball.position.y >= enemy.position.y + 30 {
            addScore(PlayerWhoWon: main)
        }
        //Player's score is score[0]
        //Enemy's score is score[1]
        
        
        
        if(score[0] >= 3){
            if (currentGameType == .player2){
                GameScene.whoWon = 3
            }else{
            GameScene.whoWon = 0
            }
            let NextScreen = GameOverScreen(fileNamed: "GameOverScreen")
            NextScreen?.scaleMode = .aspectFill
            self.scene?.view?.presentScene(NextScreen!)
        }else if(score[1] >= 3){
            if (currentGameType == .player2){
                GameScene.whoWon = 2
            }else{
                GameScene.whoWon = 1
            }
            let NextScreen = GameOverScreen(fileNamed: "GameOverScreen")
            NextScreen?.scaleMode = .aspectFill
            self.scene?.view?.presentScene(NextScreen!)
        }
        
        
    }
}
