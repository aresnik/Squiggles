//
//  SelectBoardScene.swift
//  Squiggles
//
//  Created by Alex Resnik on 11/14/23.
//

import SpriteKit
import GameplayKit
import SwiftUI
import UIKit

class SelectBoardScene: SKScene {
    
    private var selectBoardLabel: SKLabelNode = SKLabelNode()
    private var button6x6: SKLabelNode = SKLabelNode()
    private var boarder6x6: SKShapeNode = SKShapeNode()
    private var button7x7: SKLabelNode = SKLabelNode()
    private var boarder7x7: SKShapeNode = SKShapeNode()
    private var button8x8: SKLabelNode = SKLabelNode()
    private var boarder8x8: SKShapeNode = SKShapeNode()
    private var button9x9: SKLabelNode = SKLabelNode()
    private var boarder9x9: SKShapeNode = SKShapeNode()
    private var button10x10: SKLabelNode = SKLabelNode()
    private var boarder10x10: SKShapeNode = SKShapeNode()
    
    private var backColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    
    override func didMove(to view: SKView) {
        
        backgroundColor = backColor
        
        selectBoardLabel.text = "Select Board"
        selectBoardLabel.fontName = "Bold"
        selectBoardLabel.fontSize = 50
        selectBoardLabel.fontColor = .white
        selectBoardLabel.horizontalAlignmentMode = .center
        selectBoardLabel.position = CGPoint(x: size.width/2,
                                            y: size.height - long)
        selectBoardLabel.name = "selectboardlabel"
        
        addChild(selectBoardLabel)
        
        button6x6.text = "6x6 Squares"
        button6x6.fontName = "Bold"
        button6x6.fontSize = 25
        button6x6.fontColor = .white
        button6x6.horizontalAlignmentMode = .center
        button6x6.position = CGPoint(x: size.width/2 ,
                                     y: size.height*0.75 )
        button6x6.name = "button6x6"
        
        addChild(button6x6)
        
        boarder6x6 = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 85),
                                              y: Int(size.height*0.75 - 20),
                                                    width: 175,
                                                    height: 60),
                                                    cornerRadius: 30)
        boarder6x6.fillColor = .clear
        boarder6x6.strokeColor = .white
        boarder6x6.lineWidth = 2.5
        boarder6x6.name = "boarder6x6"
        
        addChild(boarder6x6)
        
        button7x7.text = "7x7 Squares"
        button7x7.fontName = "Bold"
        button7x7.fontSize = 25
        button7x7.fontColor = .white
        button7x7.horizontalAlignmentMode = .center
        button7x7.position = CGPoint(x: size.width/2,
                                     y: size.height*0.60 )
        button7x7.name = "button7x7"
        
        addChild(button7x7)
        
        boarder7x7 = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 85),
                                              y: Int(size.height*0.60 - 20),
                                                    width: 175,
                                                    height: 60),
                                                    cornerRadius: 30)
        boarder7x7.fillColor = .clear
        boarder7x7.strokeColor = .white
        boarder7x7.lineWidth = 2.5
        boarder7x7.name = "boarder7x7"
        
        addChild(boarder7x7)
        
        button8x8.text = "8x8 Squares"
        button8x8.fontName = "Bold"
        button8x8.fontSize = 25
        button8x8.fontColor = .white
        button8x8.horizontalAlignmentMode = .center
        button8x8.position = CGPoint(x: size.width/2,
                                     y: size.height*0.45 )
        button8x8 .name = "button8x8"
        
        addChild(button8x8 )
        
        boarder8x8 = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 85),
                                              y: Int(size.height*0.45 - 20),
                                                    width: 175,
                                                    height: 60),
                                                    cornerRadius: 30)
        boarder8x8.fillColor = .clear
        boarder8x8.strokeColor = .white
        boarder8x8.lineWidth = 2.5
        boarder8x8.name = "boarder8x8"
        
        addChild(boarder8x8)
        
        button9x9.text = "9x9 Squares"
        button9x9.fontName = "Bold"
        button9x9.fontSize = 25
        button9x9.fontColor = .white
        button9x9.horizontalAlignmentMode = .center
        button9x9.position = CGPoint(x: size.width/2 ,
                                     y: size.height*0.30 )
        button9x9.name = "button9x9"
        
        addChild(button9x9)
        
        boarder9x9 = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 85),
                                              y: Int(size.height*0.30 - 20),
                                                    width: 175,
                                                    height: 60),
                                                    cornerRadius: 30)
        boarder9x9.fillColor = .clear
        boarder9x9.strokeColor = .white
        boarder9x9.lineWidth = 2.5
        boarder9x9.name = "boarder9x9"
        
        addChild(boarder9x9)
        
        button10x10.text = "10x10 Squares"
        button10x10.fontName = "Bold"
        button10x10.fontSize = 25
        button10x10.fontColor = .white
        button10x10.horizontalAlignmentMode = .center
        button10x10.position = CGPoint(x: size.width/2,
                                       y: size.height*0.15 )
        button10x10.name = "button10x10"
        
        addChild(button10x10)
        
        boarder10x10 = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 100),
                                              y: Int(size.height*0.15 - 20),
                                                    width: 200,
                                                    height: 60),
                                                    cornerRadius: 30)
        boarder10x10.fillColor = .clear
        boarder10x10.strokeColor = .white
        boarder10x10.lineWidth = 2.5
        boarder10x10.name = "boarder10x10"
        
        addChild(boarder10x10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let pointOfTouch = touch.location(in: self)
            let touchedNode = self.atPoint(pointOfTouch)
            
            if touchedNode.name == "boarder6x6" {
                button6x6.fontColor = .gray
                boarder6x6.strokeColor = .gray
                boardSize = 6
            }
            if touchedNode.name == "boarder7x7" {
                button7x7.fontColor = .gray
                boarder7x7.strokeColor = .gray
                boardSize = 7
            }
            if touchedNode.name == "boarder8x8" {
                button8x8.fontColor = .gray
                boarder8x8.strokeColor = .gray
                boardSize = 8
            }
            if touchedNode.name == "boarder9x9" {
                button9x9.fontColor = .gray
                boarder9x9.strokeColor = .gray
                boardSize = 9
            }
            if touchedNode.name == "boarder10x10" {
                button10x10.fontColor = .gray
                boarder10x10.strokeColor = .gray
                boardSize = 10
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let pointOfTouch = touch.location(in: self)
            let touchedNode = self.atPoint(pointOfTouch)
            
            if touchedNode.name == "boarder6x6" {
                button6x6.fontColor = .white
                boarder6x6.strokeColor = .white
                
                changeSceneToGame()
            }
            if touchedNode.name == "boarder7x7" {
                button7x7.fontColor = .white
                boarder7x7.strokeColor = .white
                
                changeSceneToGame()
            }
            if touchedNode.name == "boarder8x8" {
                button8x8.fontColor = .white
                boarder8x8.strokeColor = .white
                
                changeSceneToGame()
            }
            if touchedNode.name == "boarder9x9" {
                button9x9.fontColor = .white
                boarder9x9.strokeColor = .white
                
                changeSceneToGame()
            }
            if touchedNode.name == "boarder10x10" {
                button10x10.fontColor = .white
                boarder10x10.strokeColor = .white
                
                changeSceneToGame()
            }
        }
    }
    
    func changeSceneToGame() {
        
        let sceneToMoveTo = GameScene(size: self.size)
        let myTransition = SKTransition.fade(withDuration: 0.5)
        
        sceneToMoveTo.scaleMode = self.scaleMode
        
        self.view?.presentScene(sceneToMoveTo, transition: myTransition)
    }
}

struct SelectBoardSceneView: View {
    
    var body: some View {
        SpriteView(scene: SelectBoardScene(size:CGSize(width: gameWidth, height: gameHeight)))
            .ignoresSafeArea()
    }
}

#Preview {
    SelectBoardSceneView()
}
