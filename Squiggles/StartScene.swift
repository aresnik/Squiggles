//
//  StartScene.swift
//  Squiggles
//
//  Created by Alex Resnik on 11/14/23.
//

import SpriteKit
import GameplayKit
import SwiftUI

class StartScene: SKScene {
    
    var splashScreen: SKSpriteNode = SKSpriteNode(imageNamed: "splashScreen")
    var squigglesLabel: SKLabelNode = SKLabelNode()

    var backColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    
    override func didMove(to view: SKView) {
        
        backgroundColor = backColor
        
        splashScreen.name = "Stop"
        splashScreen.size = CGSize(width: 600, height: 600)
        splashScreen.position = CGPoint(x: size.width/2, y: size.height*0.5)
        
        self.addChild(splashScreen)
        
        squigglesLabel.text = "Squiggles"
        squigglesLabel.fontName = "Bold"
        squigglesLabel.fontSize = 70
        squigglesLabel.fontColor = .white
        squigglesLabel.horizontalAlignmentMode = .center
        squigglesLabel.position = CGPoint(x: size.width/2,
                                     y: size.height * 0.20 )
        
        addChild(squigglesLabel)
        
        let scaleOut = SKAction.scale(to: 0.2, duration: 0)
        let scaleIn = SKAction.scale(to: 0.5, duration: 1)
        
        splashScreen.run(scaleOut)
        splashScreen.run(scaleIn)
        squigglesLabel.run(scaleOut)
        squigglesLabel.run(scaleIn)
        
        let runAction = SKAction.run { self.changeSceneToSelectBoard() }
        let waitAction = SKAction.wait(forDuration: 2)
        let sequenceAction = SKAction.sequence([waitAction, runAction])
        
        run(sequenceAction)

    }
    
    func changeSceneToSelectBoard() {
        
        let sceneToMoveTo = SelectBoardScene(size: self.size)
        let myTransition = SKTransition.fade(withDuration: 0.5)
        
        sceneToMoveTo.scaleMode = self.scaleMode
        
        self.view?.presentScene(sceneToMoveTo, transition: myTransition)
    }
}

struct StartSceneView: View {

    var body: some View {
        SpriteView(scene: StartScene(size:CGSize(width: gameWidth, height: gameHeight)))
            .ignoresSafeArea()
    }
}

#Preview {
    StartSceneView()
}

