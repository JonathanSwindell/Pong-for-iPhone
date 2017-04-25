//
//  GameViewController.swift
//  Ultmate Pong
//
//  Created by Jonathan Swindell on 2/26/17.
//  Copyright © 2017 BlueTomCat. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, AmazonAdInterstitialDelegate{

    var interstitial: AmazonAdInterstitial!
    let options = AmazonAdOptions()
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.showAmazonAd), name: NSNotification.Name(rawValue: "loadAd"), object: nil)

        super.viewDidLoad()
        
        interstitial = AmazonAdInterstitial()
        interstitial.delegate = self

        
        //options.isTestRequest = true

        interstitial.load(options)


        
            if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MenuScreen") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    func showAmazonAd() {
        interstitial.present(from: self)
    }
    
    func interstitialDidDismiss(_ interstitial: AmazonAdInterstitial!) {
            interstitial.load(options)
        }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
