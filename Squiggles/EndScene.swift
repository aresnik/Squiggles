//
//  EndScene.swift
//  Squiggles
//
//  Created by Alex Resnik on 11/14/23.
//

import SpriteKit
import GameplayKit
import SwiftUI

class EndScene: SKScene {
    
    private var gameOverLabel: SKLabelNode
    private var timeLabel: SKLabelNode
    private var movesLabel: SKLabelNode
    private var bestTimeLabel: SKLabelNode
    private var perfectGameLabel: SKLabelNode
    private var perfectStreakLabel: SKLabelNode
    private var longestStreakLabel: SKLabelNode
    private var playAgainButton: SKLabelNode
    private var playAgainBoarder: SKShapeNode
    
    private var backColor: UIColor
    
    override init(size: CGSize) {
        
        gameOverLabel = SKLabelNode()
        timeLabel = SKLabelNode()
        movesLabel = SKLabelNode()
        bestTimeLabel = SKLabelNode()
        perfectGameLabel = SKLabelNode()
        perfectStreakLabel = SKLabelNode()
        longestStreakLabel = SKLabelNode()
        playAgainButton = SKLabelNode()
        playAgainBoarder = SKShapeNode()
        
        backColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        super.init(size: size)
    
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = backColor
        
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontName = "Bold"
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.position = CGPoint(x: size.width/2,
                                         y: size.height - long)
        gameOverLabel.name = "gameover"
        
        addChild(gameOverLabel)
        
        timeLabel.text = "Time: \(timeCurrent)"
        timeLabel.fontName = "Bold"
        timeLabel.fontSize = 25
        timeLabel.fontColor = SKColor.white
        timeLabel.horizontalAlignmentMode = .left
        timeLabel.position = CGPoint(x: gameOverLabel.frame.minX + 20,
                                     y: size.height*0.75 )
        timeLabel.name = "timeLabel"
        
        addChild(timeLabel)
        
        movesLabel.text = "Moves: \(moves)"
        movesLabel.fontName = "Bold"
        movesLabel.fontSize = 25
        movesLabel.fontColor = SKColor.white
        movesLabel.horizontalAlignmentMode = .left
        movesLabel.position = CGPoint(x: gameOverLabel.frame.minX  + 20,
                                     y: size.height*0.65 )
        timeLabel.name = "movesLabel"
        
        addChild(movesLabel)
        
        bestTimeLabel.text = "Best Time: \(timeBest)"
        bestTimeLabel.fontName = "Bold"
        bestTimeLabel.fontSize = 25
        bestTimeLabel.fontColor = SKColor.white
        bestTimeLabel.horizontalAlignmentMode = .left
        bestTimeLabel.position = CGPoint(x: gameOverLabel.frame.minX  + 20,
                                          y: size.height*0.55 )
        bestTimeLabel .name = "bestTimelabel"
        
        addChild(bestTimeLabel )
        
        perfectGameLabel.text = "Perfect Games: \(perfectGames)"
        perfectGameLabel.fontName = "Bold"
        perfectGameLabel.fontSize = 25
        perfectGameLabel.fontColor = SKColor.white
        perfectGameLabel.horizontalAlignmentMode = .left
        perfectGameLabel.position = CGPoint(x: gameOverLabel.frame.minX  + 20,
                                     y: size.height*0.45 )
        perfectGameLabel.name = "perfectgamelabel"
        
        addChild(perfectGameLabel)
        
        perfectStreakLabel.text = "Perfect Streak: \(perfectStreak)"
        perfectStreakLabel.fontName = "Bold"
        perfectStreakLabel.fontSize = 25
        perfectStreakLabel.fontColor = SKColor.white
        perfectStreakLabel.horizontalAlignmentMode = .left
        perfectStreakLabel.position = CGPoint(x: gameOverLabel.frame.minX  + 20,
                                     y: size.height*0.35 )
        perfectStreakLabel.name = "perfectstreaklabel"
        
        addChild(perfectStreakLabel)
        
        longestStreakLabel.text = "Longest Streak: \(longestStreak)"
        longestStreakLabel.fontName = "Bold"
        longestStreakLabel.fontSize = 25
        longestStreakLabel.fontColor = SKColor.white
        longestStreakLabel.horizontalAlignmentMode = .left
        longestStreakLabel.position = CGPoint(x: gameOverLabel.frame.minX  + 20,
                                          y: size.height*0.25 )
        longestStreakLabel .name = "longeststreaklabel"
        
        addChild(longestStreakLabel)
        
        playAgainButton.text = "Play Again"
        playAgainButton.fontName = "Bold"
        playAgainButton.fontSize = 25
        playAgainButton.fontColor = SKColor.white
        playAgainButton.horizontalAlignmentMode = .center
        playAgainButton.position = CGPoint(x: Int(size.width/2), y: Int(size.height*0.2 - 80))
        playAgainButton.name = "playagian"
        
        addChild(playAgainButton)
        
        playAgainBoarder = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 75),
                                                    y: Int(size.height*0.2 - 102),
                                                    width: 150,
                                                    height: 60),
                                                    cornerRadius: 30)
        playAgainBoarder.fillColor = .clear
        playAgainBoarder.strokeColor = .white
        playAgainBoarder.lineWidth = 2.5
        playAgainBoarder.name = "playagainboarder"
        
        addChild(playAgainBoarder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let pointOfTouch = touch.location(in: self)
            let touchedNode = self.atPoint(pointOfTouch)
            
            if touchedNode.name == "playagainboarder" {
                playAgainButton.fontColor = SKColor.gray
                playAgainBoarder.strokeColor = SKColor.gray
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let pointOfTouch = touch.location(in: self)
            let touchedNode = self.atPoint(pointOfTouch)
            
            if touchedNode.name == "playagainboarder" {
                playAgainButton.fontColor = SKColor.white
                playAgainBoarder.strokeColor = SKColor.white
                
                 changeScene()
            }
        }
    }
    
    func changeScene() {
        
        let sceneToMoveTo = GameScene(size: self.size)
        let myTransition = SKTransition.fade(withDuration: 0.5)
        
        sceneToMoveTo.scaleMode = self.scaleMode
        
        self.view?.presentScene(sceneToMoveTo, transition: myTransition)
    }
}

struct EndSceneView: View {

    var body: some View {
        VStack {
            SpriteView(scene: EndScene(size:CGSize(width: gameWidth, height: gameHeight)))
                .ignoresSafeArea()
        }
    }
}

#Preview {
    EndSceneView()
}
