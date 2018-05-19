//  GameScene.swift
//  Ultmate Pong
//
//  Created by Jonathan Swindell on 2/26/17.
//  Copyright © 2017 BlueTomCat. All rights reserved.
//

import SpriteKit
import GameplayKit

//Game modes
enum gameType {
    case easy
    case medium
    case hard
    case player2
    case endless
}

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    //Variable declarations
    var currentGameType = gameType.easy
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    var score = [Int]()
    static var whoWon = 0
    //whoWon KEY:
        //single player
        //0 = You won
        //1 = opponent won
        //two player one device
        //2 = top player won
        //3 = button pleyer won
    let userDefaults = UserDefaults.standard
    //gameplay tweaking varibles
    let initalBallDelay = 1.5
    let subsequentBallDelay = 0.85
    let ballVelocity:Int = 395
    let TwoPlayerMatchControlDelay = 0.45
    let SinglePlayerControlDelay = 0.275
    let easyAIDelay = 1.075 //Balenced
    let mediumAIDelay = 0.9 //Balenced
    let hardAIDelay = 0.835 //Balenced
    let endlessAIDelay = 1.0
    let minVariation = 0.0
    let maxVariation = 0.765
    //Perfectly balenced like all things should be... quote - Thanos 2018
    
    //didMove is called when GameScene is presented
    override func didMove(to view: SKView) {
        //plays transition sound
        let ButtonTapSound = SKAction.playSoundFileNamed("Selection",waitForCompletion: false)
        run(ButtonTapSound)
        
        //sets gametype from Mode key
        if (userDefaults.integer(forKey: "Mode")==0){
            currentGameType = gameType.easy
        }else if(userDefaults.integer(forKey: "Mode")==1){
            currentGameType = gameType.medium
        }else if(userDefaults.integer(forKey: "Mode")==2){
            currentGameType = gameType.hard
        }else if(userDefaults.integer(forKey: "Mode")==3){
            currentGameType = gameType.player2
        }else if(userDefaults.integer(forKey: "Mode")==4){
            currentGameType = gameType.endless
        }
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        //hide enemy score and repositions your score if the game mode is set to endless
        if(currentGameType == gameType.endless){
            topLabel.isHidden = true
            bottomLabel.position = CGPoint(x: 0, y: 25)
        }
        
        //sets up border physic
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
        //adds impules to ball after a delay
        let DicideInpulseDirection = Int(arc4random_uniform(UInt32(4))) + 1
            let timer = DispatchTime.now() + initalBallDelay
            DispatchQueue.main.asyncAfter(deadline: timer) {
                switch(DicideInpulseDirection){
                case 1:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: self.ballVelocity, dy: self.ballVelocity))
                case 2:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: -self.ballVelocity, dy: -self.ballVelocity))
                case 3:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: -self.ballVelocity, dy: self.ballVelocity))
                case 4:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: self.ballVelocity, dy: -self.ballVelocity))
                default:
                    self.ball.physicsBody?.applyImpulse(CGVector(dx: self.ballVelocity, dy: self.ballVelocity))
            }
        }
    }

    func addScore(PlayerWhoWon: SKSpriteNode) {
        //repositions ball and sets velocity to zero
        ball.position = CGPoint(x:0,y:0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        //randomly choices which direction
        let DicideInpulseDirection = Int(arc4random_uniform(UInt32(4))) + 1
        if PlayerWhoWon == main{
            //updates score
            score[0] += 1
            //adds impules to ball after a delay
            let timer = DispatchTime.now() + subsequentBallDelay
            DispatchQueue.main.asyncAfter(deadline: timer) {
            switch(DicideInpulseDirection){
            case 1:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: self.ballVelocity, dy: self.ballVelocity))
            case 2:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: -self.ballVelocity, dy: -self.ballVelocity))
            case 3:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: -self.ballVelocity, dy: self.ballVelocity))
            case 4:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: self.ballVelocity, dy: -self.ballVelocity))
            default:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: self.ballVelocity, dy: self.ballVelocity))
                }
            }
        }else if PlayerWhoWon == enemy{
            //updates score
            score[1] += 1
            //adds impules to ball after a delay
            let timer = DispatchTime.now() + subsequentBallDelay
            DispatchQueue.main.asyncAfter(deadline: timer) {
            switch(DicideInpulseDirection){
            case 1:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: self.ballVelocity, dy: self.ballVelocity))
            case 2:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: -self.ballVelocity, dy: -self.ballVelocity))
            case 3:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: -self.ballVelocity, dy: self.ballVelocity))
            case 4:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: self.ballVelocity, dy: -self.ballVelocity))
            default:
                self.ball.physicsBody?.applyImpulse(CGVector(dx: self.ballVelocity, dy: self.ballVelocity))
                }
            }
        }
        //updates score text
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: SinglePlayerControlDelay))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player2{
                if location.y > 0{
                    enemy.run(SKAction.moveTo(x: location.x, duration: TwoPlayerMatchControlDelay))
                }
                
                if location.y < 0{
                    main.run(SKAction.moveTo(x: location.x, duration: TwoPlayerMatchControlDelay))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: SinglePlayerControlDelay))
            }
            
        }
        
    }
    
  
    override func update(_ currentTime: TimeInterval) {
        var randomVariation = randomDouble(min: minVariation, max: maxVariation)
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: easyAIDelay + randomVariation))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: mediumAIDelay + randomVariation))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: hardAIDelay + randomVariation))
            break
        case .player2:
            break
        case .endless:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: endlessAIDelay + randomVariation))
            break
        }
        
        //plays sound if ball hits paddel
        if ball.intersects(main)||ball.intersects(enemy){
            let ButtonTapSound = SKAction.playSoundFileNamed("Bounce",waitForCompletion: false)
            run(ButtonTapSound)
        }
        
        if ball.position.y > 0{
            ball.color = (UIColor.init(red: ball.position.y/255, green: 0, blue: 0, alpha: 1))
        }
        if ball.position.y < 0{
            ball.color = (UIColor.init(red: 0, green: 0, blue: ball.position.y/(-255), alpha: 1))
            //255 has to be negative because the ball's positon is negative.
        }
        
        // add scores
        if ball.position.y <= main.position.y - 30{
            addScore(PlayerWhoWon: enemy)
        }else if ball.position.y >= enemy.position.y + 30 {
            addScore(PlayerWhoWon: main)
        }
        //Player's score is score[0]
        //Enemy's score is score[1]
        
        //handles endless
        if(!(currentGameType == gameType.endless)){
        if(score[0] >= 5){
            if (currentGameType == .player2){
                GameScene.whoWon = 3
            }else{
            GameScene.whoWon = 0
            }
            let NextScreen = GameOverScreen(fileNamed: "GameOverScreen")
            NextScreen?.scaleMode = .aspectFill
            self.scene?.view?.presentScene(NextScreen!)
        }else if(score[1] >= 5){
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
        if(currentGameType == gameType.endless){
            if(score[1] >= 1){
                GameScene.whoWon = 4
                if(userDefaults.integer(forKey: "HighScore") < score[0]){
                    userDefaults.set(score[0], forKey: "HighScore")
                }
                userDefaults.set(score[0], forKey: "CurrentScore")
                let NextScreen = GameOverScreen(fileNamed: "GameOverScreen")
                NextScreen?.scaleMode = .aspectFill
                self.scene?.view?.presentScene(NextScreen!)
                
            }
        }
        
    }
    
    func randomDouble(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
