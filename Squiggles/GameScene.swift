//
//  GameScene.swift
//  Squiggles
//
//  Created by Alex Resnik on 11/10/23.
//

import SpriteKit
import GameplayKit
import AVFAudio
import SwiftUI
import UIKit
import GameKit
import StoreKit

var moves: Int = 0
var timeCurrent: String = ""
var timeBest: String = ""
var perfectGames: Int = 0
var perfectStreak: Int = 0
var longestStreak: Int = 0
var boardSize: Int = 6

class GameScene: SKScene, GKGameCenterControllerDelegate, 
                 SKProductsRequestDelegate, SKPaymentTransactionObserver {

    private var sound: Bool = true
    
    private var leaderboardID: String = "elapsed6x6_squiggles"
    private var productID: String = "coffee_squiggles"
    private var product: SKProduct?
    
    private var defaults: UserDefaults = UserDefaults.standard
    
    private var backColor: SKColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    
    private var squiggles: [Squiggle] = []
    private var lines: [Line] = []
    
    // Initial squiggles
    private var squiggles6: [Squiggle] = [
        Squiggle(color: .red,    middle: [0,  6, 12, 18, 24,
                                          30, 31, 32, 33, 34, 35]),
        Squiggle(color: .blue,   middle: [1,  7, 13, 19, 25]),
        Squiggle(color: .green,  middle: [2,  8, 14, 20, 26]),
        Squiggle(color: .orange, middle: [3,  9, 15, 21, 27]),
        Squiggle(color: .yellow, middle: [4, 10, 16, 22, 28]),
        Squiggle(color: .gray  , middle: [5, 11, 17, 23, 29]) ]
    
    private var squiggles7: [Squiggle] = [
        Squiggle(color: .red,    middle: [0,  7, 14, 21, 28, 35,
                                          42, 43, 44, 45, 46, 47, 48]),
        Squiggle(color: .blue,   middle: [1,  8, 15, 22, 29, 36]),
        Squiggle(color: .green,  middle: [2,  9, 16, 23, 30, 37]),
        Squiggle(color: .orange, middle: [3, 10, 17, 24, 31, 38]),
        Squiggle(color: .yellow, middle: [4, 11, 18, 25, 32, 39]),
        Squiggle(color: .gray  , middle: [5, 12, 19, 26, 33, 40]),
        Squiggle(color: .purple, middle: [6, 13, 20, 27, 34, 41]) ]
    
    private var squiggles8: [Squiggle] = [
        Squiggle(color: .red,    middle: [0,  8, 16, 24, 32, 40, 48,
                                          56, 57, 58, 59, 60, 61, 62, 63]),
        Squiggle(color: .blue,   middle: [1,  9, 17, 25, 33, 41, 49]),
        Squiggle(color: .green,  middle: [2, 10, 18, 26, 34, 42, 50]),
        Squiggle(color: .orange, middle: [3, 11, 19, 27, 35, 43, 51]),
        Squiggle(color: .yellow, middle: [4, 12, 20, 28, 36, 44, 52]),
        Squiggle(color: .gray  , middle: [5, 13, 21, 29, 37, 45, 53]),
        Squiggle(color: .purple, middle: [6, 14, 22, 30, 38, 46, 54]),
        Squiggle(color: .brown,  middle: [7, 15, 23, 31, 39, 47, 55]) ]
    
    private var squiggles9: [Squiggle] = [
        Squiggle(color: .red,    middle: [0,  9, 18, 27, 36, 45, 54, 63,
                                          72, 73, 74, 75, 76, 77, 78, 79, 80]),
        Squiggle(color: .blue,   middle: [1, 10, 19, 28, 37, 46, 55, 64]),
        Squiggle(color: .green,  middle: [2, 11, 20, 29, 38, 47, 56, 65]),
        Squiggle(color: .orange, middle: [3, 12, 21, 30, 39, 48, 57, 66]),
        Squiggle(color: .yellow, middle: [4, 13, 22, 31, 40, 49, 58, 67]),
        Squiggle(color: .gray  , middle: [5, 14, 23, 32, 41, 50, 59, 68]),
        Squiggle(color: .purple, middle: [6, 15, 24, 33, 42, 51, 60, 69]),
        Squiggle(color: .brown,  middle: [7, 16, 25, 34, 43, 52, 61, 70]),
        Squiggle(color: .cyan,   middle: [8, 17, 26, 35, 44, 53, 62, 71]) ]
    
    private var squiggles10: [Squiggle] = [
        Squiggle(color: .red,    middle: [0, 10, 20, 30, 40, 50, 60, 70, 80,
                                          90, 91, 92, 93, 94, 95, 96, 97, 98, 99]),
        Squiggle(color: .blue,    middle: [1, 11, 21, 31, 41, 51, 61, 71, 81]),
        Squiggle(color: .green,   middle: [2, 12, 22, 32, 42, 52, 62, 72, 82]),
        Squiggle(color: .orange,  middle: [3, 13, 23, 33, 43, 53, 63, 73, 83]),
        Squiggle(color: .yellow,  middle: [4, 14, 24, 34, 44, 54, 64, 74, 84]),
        Squiggle(color: .gray  ,  middle: [5, 15, 25, 35, 45, 55, 65, 75, 85]),
        Squiggle(color: .purple,  middle: [6, 16, 26, 36, 46, 56, 66, 76, 86]),
        Squiggle(color: .brown,   middle: [7, 17, 27, 37, 47, 57, 67, 77, 87]),
        Squiggle(color: .cyan,    middle: [8, 18, 28, 38, 48, 58, 68, 78, 88]),
        Squiggle(color: .magenta, middle: [9, 19, 29, 39, 49, 59, 69, 79, 89]) ]
    
    private var lines6: [Line] = [
        Line(color: .red,    segment: []),
        Line(color: .blue,   segment: []),
        Line(color: .green,  segment: []),
        Line(color: .orange, segment: []),
        Line(color: .yellow, segment: []),
        Line(color: .gray  , segment: []) ]
    
    private var lines7: [Line] = [
        Line(color: .red,    segment: []),
        Line(color: .blue,   segment: []),
        Line(color: .green,  segment: []),
        Line(color: .orange, segment: []),
        Line(color: .yellow, segment: []),
        Line(color: .gray  , segment: []),
        Line(color: .purple, segment: []) ]
    
    private var lines8: [Line] = [
        Line(color: .red,    segment: []),
        Line(color: .blue,   segment: []),
        Line(color: .green,  segment: []),
        Line(color: .orange, segment: []),
        Line(color: .yellow, segment: []),
        Line(color: .gray  , segment: []),
        Line(color: .purple, segment: []),
        Line(color: .brown,  segment: []) ]
    
    private var lines9: [Line] = [
        Line(color: .red,    segment: []),
        Line(color: .blue,   segment: []),
        Line(color: .green,  segment: []),
        Line(color: .orange, segment: []),
        Line(color: .yellow, segment: []),
        Line(color: .gray  , segment: []),
        Line(color: .purple, segment: []),
        Line(color: .brown,  segment: []),
        Line(color: .cyan,   segment: []) ]
    
    private var lines10: [Line] = [
        Line(color: .red,    segment: []),
        Line(color: .blue,   segment: []),
        Line(color: .green,  segment: []),
        Line(color: .orange, segment: []),
        Line(color: .yellow, segment: []),
        Line(color: .gray  , segment: []),
        Line(color: .purple, segment: []),
        Line(color: .brown,  segment: []),
        Line(color: .cyan,   segment: []),
        Line(color: .magenta, segment: []) ]
    
    private var lineNames: [String] = []
    
    private var solution: Bool = false
    private let settingsButton: SKSpriteNode = SKSpriteNode(imageNamed: "gear")
    private var selectBoardButton: SKLabelNode = SKLabelNode()
    private var selectBoardBoarder: SKShapeNode = SKShapeNode()
    private var solutionButton: SKLabelNode = SKLabelNode()
    private var solutionBoarder: SKShapeNode = SKShapeNode()
    private var timeLabel: SKLabelNode = SKLabelNode()
    private var movesLabel: SKLabelNode = SKLabelNode()
    private var grid: [SKShapeNode] = []
    private var overlay: [SKShapeNode] = []
    private var dot: [SKShapeNode] = []
    private var dots: [Dot] = []
    private var k: Int = 0
    private var time: String = "00:00"
    private var solved: Bool = false
    private var message: String = "SOLVED!"
    
    private var popOver: SKShapeNode = SKShapeNode()
    private var winLabel: SKLabelNode = SKLabelNode()
    private var okButton: SKLabelNode = SKLabelNode()
    private var okBoarder: SKShapeNode = SKShapeNode()
    
    private let backButton: SKSpriteNode = SKSpriteNode(imageNamed: "back")
    private var settingsLabel: SKLabelNode = SKLabelNode()
    private var soundButton: SKLabelNode = SKLabelNode()
    private var soundBoarder: SKShapeNode = SKShapeNode()
    private var reviewButton: SKLabelNode = SKLabelNode()
    private var reviewBoarder: SKShapeNode = SKShapeNode()
    private var websiteButton: SKLabelNode = SKLabelNode()
    private var websiteBoarder: SKShapeNode = SKShapeNode()
    private var resetButton: SKLabelNode = SKLabelNode()
    private var resetBoarder: SKShapeNode = SKShapeNode()
    private var tipTheDevButton: SKLabelNode  = SKLabelNode()
    private var tipTheDevBoarder: SKShapeNode = SKShapeNode()
    
    private var color: [SKColor] = []
    
    private var color6: [SKColor] = [
        .red, .blue, .green, .orange, .yellow, .gray ].shuffled()
    private var color7: [SKColor] = [
        .red, .blue, .green, .orange, .yellow, .gray, .purple ].shuffled()
    private var color8: [SKColor] = [
        .red, .blue, .green, .orange, .yellow, .gray, .purple, .brown ].shuffled()
    private var color9: [SKColor] = [
        .red, .blue, .green, .orange, .yellow, .gray, .purple, .brown, .cyan ].shuffled()
    private var color10: [SKColor] = [
        .red, .blue, .green, .orange, .yellow, .gray, .purple, .brown, .cyan, .magenta ].shuffled()
    
    private var soundPlayer: AVAudioPlayer? = AVAudioPlayer()
    
    private var pauseTimer: Bool = false
    private var isConnected: Bool = false
    private var lastDotColor: SKColor = .clear
    private var timer: Timer = Timer()
    private var elapsed: Int = 0
    private var elapsedBest: Int = 0
    private var onceStartTime: Bool = false
    
    private let cols: Int = boardSize
    private let rows: Int = boardSize
    private let numberOfGrids: Int = boardSize*boardSize
    private let sizeRatio: CGFloat = 6/CGFloat(boardSize)
    private let wH: Int =  Int(60*6/CGFloat(boardSize))
    
    struct Squiggle {
        var color: SKColor
        var middle: [Int]
    }
    
    struct Line: Equatable {
        var color: SKColor
        var segment: [Int]
    }
    
    struct Dot: Equatable {
        var color: SKColor
        var dot: Int
    }
    
    func lineNamesArray() {
        for i in 0..<numberOfGrids {
            lineNames.append(String(i))
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    override func didMove(to view: SKView) {
        
        if boardSize == 6  { leaderboardID = "elapsed6x6_squiggles"  }
        if boardSize == 7  { leaderboardID = "elapsed7x7_squiggles"  }
        if boardSize == 8  { leaderboardID = "elapsed8x8_squiggles"  }
        if boardSize == 9  { leaderboardID = "elapsed9x9_squiggles"  }
        if boardSize == 10 { leaderboardID = "elapsed10x10_squiggles" }
        
        if boardSize == 6  { color = color6  }
        if boardSize == 7  { color = color7  }
        if boardSize == 8  { color = color8  }
        if boardSize == 9  { color = color9  }
        if boardSize == 10 { color = color10 }
        
        if boardSize == 6  { squiggles = squiggles6  }
        if boardSize == 7  { squiggles = squiggles7  }
        if boardSize == 8  { squiggles = squiggles8  }
        if boardSize == 9  { squiggles = squiggles9  }
        if boardSize == 10 { squiggles = squiggles10 }
        
        if boardSize == 6  { lines = lines6  }
        if boardSize == 7  { lines = lines7  }
        if boardSize == 8  { lines = lines8  }
        if boardSize == 9  { lines = lines9  }
        if boardSize == 10 { lines = lines10 }
        
        load()
        randomize()
        board()
        lineNamesArray()
        fetchProducts()
        
        if GKLocalPlayer.local.isAuthenticated {
            GKAccessPoint.shared.isActive = false
        } else {
            print("Game Center not authenticated")
        }
        
        backgroundColor = backColor
        
        settingsButton.size.width = 30
        settingsButton.size.height = 30
        settingsButton.position.x = size.width - longButton
        settingsButton.position.y = size.height - longButton
        settingsButton.name = "settingsbutton"
        
        addChild(settingsButton)
        
        selectBoardButton.text = "Select Board"
        selectBoardButton.fontName = "Bold"
        selectBoardButton.fontSize = 20
        selectBoardButton.fontColor = .white
        selectBoardButton.horizontalAlignmentMode = .left
        selectBoardButton.position = CGPoint(x: grid[0].position.x + 15,
                                             y: size.height - long - 20 )
        selectBoardButton.name = "selectboardbutton"
        
        addChild(selectBoardButton)
        
        selectBoardBoarder = SKShapeNode(rect: CGRect(x: Int(grid[0].position.x),
                                                      y: Int(size.height - long - 37),
                                                      width: 150,
                                                      height: 50),
                                         cornerRadius: 25)
        selectBoardBoarder.fillColor = .clear
        selectBoardBoarder.strokeColor = .white
        selectBoardBoarder.lineWidth = 2.5
        selectBoardBoarder.name = "selectboardboarder"
        
        addChild(selectBoardBoarder)
        
        solutionButton.text = "Show Solution"
        solutionButton.fontName = "Bold"
        solutionButton.fontSize = 20
        solutionButton.fontColor = .white
        solutionButton.horizontalAlignmentMode = .left
        solutionButton.position = CGPoint(x: size.width*0.53 ,
                                          y: size.height - long - 20 )
        solutionButton.name = "solutionbutton"
        
        addChild(solutionButton)
        
        solutionBoarder = SKShapeNode(rect: CGRect(x: Int(size.width*0.56 - 28),
                                                   y: Int(size.height - long - 37),
                                                   width: 160,
                                                   height: 50),
                                      cornerRadius: 25)
        solutionBoarder.fillColor = .clear
        solutionBoarder.strokeColor = .white
        solutionBoarder.lineWidth = 2.5
        solutionBoarder.name = "solutionboarder"
        
        addChild(solutionBoarder)
        
        timeLabel.text = "Time: \(time)"
        timeLabel.fontName = "Bold"
        timeLabel.fontSize = 20
        timeLabel.fontColor = .white
        timeLabel.horizontalAlignmentMode = .left
        timeLabel.position = CGPoint(x: grid[0].position.x + 5,
                                     y: grid[0].position.y + CGFloat(wH) + 5)
        timeLabel.name = "time"
        
        addChild(timeLabel)
        
        movesLabel.text = "Moves: \(moves) of \(boardSize)"
        movesLabel.fontName = "Bold"
        movesLabel.fontSize = 20
        movesLabel.fontColor = .white
        movesLabel.horizontalAlignmentMode = .left
        movesLabel.position = CGPoint(x: size.width/2,
                                      y: grid[0].position.y + CGFloat(wH) + 5)
        movesLabel.name = "moves"
        
        addChild(movesLabel)
    }
    
    func popOverSettings() {
        
        popOver = SKShapeNode(rect: CGRect(x: 0,
                                           y: 0,
                                           width: size.width,
                                           height: size.height))
        popOver.fillColor = .black
        popOver.lineWidth = 0
        popOver.zPosition = 3
        
        addChild(popOver)
        
        backButton.size.width = 30
        backButton.size.height = 30
        backButton.position.x = longButton
        backButton.position.y = size.height - longButton
        backButton.name = "backbutton"

        popOver.addChild(backButton)
        
        settingsLabel.text = "Settings"
        settingsLabel.fontName = "Bold"
        settingsLabel.fontSize = 50
        settingsLabel.fontColor = .white
        settingsLabel.horizontalAlignmentMode = .center
        settingsLabel.position = CGPoint(x: size.width/2,
                                            y: size.height - long)
        settingsLabel.name = "settingslabel"
        
        popOver.addChild(settingsLabel)
        
        if sound == true {
            soundButton.text = "Sound: On"
        } else {
            soundButton.text = "Sound: Off"
        }
        soundButton.fontName = "Bold"
        soundButton.fontSize = 25
        soundButton.fontColor = .white
        soundButton.horizontalAlignmentMode = .center
        soundButton.position = CGPoint(x: size.width/2 ,
                                     y: size.height*0.75 )
        soundButton.zPosition = 4
        soundButton.name = "soundbutton"
        
        popOver.addChild(soundButton)
        
        soundBoarder = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 80),
                                              y: Int(size.height*0.75 - 20),
                                                    width: 160,
                                                    height: 60),
                                                    cornerRadius: 30)
        soundBoarder.fillColor = .clear
        soundBoarder.strokeColor = .white
        soundBoarder.lineWidth = 2.5
        soundBoarder.zPosition = 5
        soundBoarder.name = "soundboarder"
        
        popOver.addChild(soundBoarder)
        
        reviewButton.text = "Review App"
        reviewButton.fontName = "Bold"
        reviewButton.fontSize = 25
        reviewButton.fontColor = .white
        reviewButton.horizontalAlignmentMode = .center
        reviewButton.position = CGPoint(x: size.width/2,
                                     y: size.height*0.60 )
        reviewButton.zPosition = 4
        reviewButton.name = "reviewbutton"

        popOver.addChild(reviewButton)
        
        reviewBoarder = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 85),
                                              y: Int(size.height*0.60 - 20),
                                                    width: 170,
                                                    height: 60),
                                                    cornerRadius: 30)
        reviewBoarder.fillColor = .clear
        reviewBoarder.strokeColor = .white
        reviewBoarder.lineWidth = 2.5
        reviewBoarder.zPosition = 5
        reviewBoarder.name = "reviewboarder"

        popOver.addChild(reviewBoarder)
        
        websiteButton.text = "Website"
        websiteButton.fontName = "Bold"
        websiteButton.fontSize = 25
        websiteButton.fontColor = .white
        websiteButton.horizontalAlignmentMode = .center
        websiteButton.position = CGPoint(x: size.width/2 ,
                                     y: size.height*0.45 )
        websiteButton.zPosition = 4
        websiteButton.name = "websitebutton"

        popOver.addChild(websiteButton)

        websiteBoarder = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 60),
                                              y: Int(size.height*0.45 - 20),
                                                    width: 125,
                                                    height: 60),
                                                    cornerRadius: 30)
        websiteBoarder.fillColor = .clear
        websiteBoarder.strokeColor = .white
        websiteBoarder.lineWidth = 2.5
        websiteBoarder.zPosition = 5
        websiteBoarder.name = "websiteboarder"

        popOver.addChild(websiteBoarder)
        
        resetButton.text = "Reset Progress"
        resetButton.fontName = "Bold"
        resetButton.fontSize = 25
        resetButton.fontColor = .white
        resetButton.horizontalAlignmentMode = .center
        resetButton.position = CGPoint(x: size.width/2,
                                     y: size.height*0.30 )
        resetButton.zPosition = 4
        resetButton .name = "resetbutton"

        popOver.addChild(resetButton )

        resetBoarder = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 105),
                                              y: Int(size.height*0.30 - 20),
                                                    width: 208,
                                                    height: 60),
                                                    cornerRadius: 30)
        resetBoarder.fillColor = .clear
        resetBoarder.strokeColor = .white
        resetBoarder.lineWidth = 2.5
        resetBoarder.zPosition = 5
        resetBoarder.name = "resetboarder"

        popOver.addChild(resetBoarder)

        tipTheDevButton.text = "Buy Me A Coffee"
        tipTheDevButton.fontName = "Bold"
        tipTheDevButton.fontSize = 25
        tipTheDevButton.fontColor = .white
        tipTheDevButton.horizontalAlignmentMode = .center
        tipTheDevButton.position = CGPoint(x: size.width/2,
                                       y: size.height*0.15 )
        tipTheDevButton.zPosition = 4
        tipTheDevButton.name = "tipthedevbutton"

        popOver.addChild(tipTheDevButton)

        tipTheDevBoarder = SKShapeNode(rect: CGRect(x: Int(size.width/2 - 110),
                                              y: Int(size.height*0.15 - 20),
                                                    width: 220,
                                                    height: 60),
                                                    cornerRadius: 30)
        tipTheDevBoarder.fillColor = .clear
        tipTheDevBoarder.strokeColor = .white
        tipTheDevBoarder.lineWidth = 2.5
        tipTheDevBoarder.zPosition = 5
        tipTheDevBoarder.name = "tipthedevboarder"

        popOver.addChild(tipTheDevBoarder)
    }
    
    func popOverDialogue() {
        
        popOver = SKShapeNode(rect: CGRect(x: Int(self.size.width/2 - 125),
                                           y: Int(self.size.height/2 - 125), width: 250, height: 250))
        popOver.fillColor = .black
        popOver.strokeColor = .white
        popOver.lineWidth = 10
        popOver.zPosition = 3
        
        self.addChild(popOver)
        
        winLabel.text = message
        winLabel.fontName = "Bold"
        winLabel.fontSize = 20
        winLabel.fontColor = .white
        winLabel.horizontalAlignmentMode = .center
        winLabel.position = CGPoint(x: Int(self.size.width/2),
                                    y: Int(self.size.height/2 + 40))
        winLabel.zPosition = 4
        winLabel.name = "winlabel"
        
        popOver.addChild(winLabel)
        
        okButton.text = "OK"
        okButton.fontName = "Bold"
        okButton.fontSize = 20
        okButton.fontColor = .white
        okButton.horizontalAlignmentMode = .center
        okButton.position = CGPoint(x: Int(self.size.width/2),
                                    y: Int(self.size.height/2 - 60))
        okButton.zPosition = 4
        okButton.name = "ok"
        
        popOver.addChild(okButton)
        
        okBoarder = SKShapeNode(rect: CGRect(x: Int(self.size.width/2 - 30),
                                             y: Int(self.size.height/2 - 77), width: 60, height: 50),
                                cornerRadius: 25)
        okBoarder.fillColor = .clear
        okBoarder.strokeColor = .white
        okBoarder.lineWidth = 2.5
        okBoarder.zPosition = 5
        okBoarder.name = "okboarder"
        
        popOver.addChild(okBoarder)
        
    }
    
    func showResetAlert(withTitle title: String, message: String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            let allKeys = NSUbiquitousKeyValueStore.default.dictionaryRepresentation.keys
            for key in allKeys {
                NSUbiquitousKeyValueStore.default.removeObject(forKey: key)
            }
        }
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { _ in }
        alertController.addAction(noAction)
        
        view?.window?.rootViewController?.present(alertController, animated: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let pointOfTouch = touch.location(in: self)
            let touchedNode = self.atPoint(pointOfTouch)
            
            for i in 0..<numberOfGrids {
                if touchedNode == overlay[i] {
                    if !solution {
                        move(i: i)
                        drawLine()
                        countMoves(i: i)
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let pointOfTouch = touch.location(in: self)
            let touchedNode = self.atPoint(pointOfTouch)
            
            for i in 0..<numberOfGrids {
                if touchedNode == overlay[i] {
                    start(i: i)
                    deleteLine(i: i)
                    animateDot(i: i)
                    if !onceStartTime {
                        elapsedTime()
                        onceStartTime = true
                    }
                    pauseTimer = false
                }
            }
            
            if touchedNode.name == "selectboardboarder" {
                selectBoardButton.fontColor = .gray
                selectBoardBoarder.strokeColor = .gray
            }
            
            if touchedNode.name == "solutionboarder" {
                if !solution {
                    solutionButton.text = "Hide Solution"
                    middle()
                    self.children
                        .filter { lineNames.contains($0.name ?? "") }
                        .forEach { node in
                            node.removeFromParent()
                        }
                    solution.toggle()
                } else {
                    solutionButton.text = "Show Solution"
                    drawLine()
                    self.children
                        .filter { $0.name == "line" }
                        .forEach { node in
                            node.removeFromParent()
                        }
                    solution.toggle()
                }
            }
            
            if touchedNode.name == "okboarder" {
                okButton.fontColor = SKColor.gray
                okBoarder.strokeColor = SKColor.gray
            }
            
            if touchedNode.name == "settingsbutton" && !solved {
                settingsButton.texture = SKTexture(imageNamed: "gear.fill")
            }
            if touchedNode.name == "backbutton" {
                backButton.texture = SKTexture(imageNamed: "back.fill")
            }
            if touchedNode.name == "soundboarder" {
                if sound == true {
                    sound = false
                    soundButton.text = "Sound: Off"
                } else {
                    sound = true
                    soundButton.text = "Sound: On"
                }
                defaults.set(sound, forKey: "sound")
            }
            if touchedNode.name == "reviewboarder" {
                reviewButton.fontColor = .gray
                reviewBoarder.strokeColor = .gray
            }
            if touchedNode.name == "websiteboarder" {
                websiteButton.fontColor = .gray
                websiteBoarder.strokeColor = .gray
            }
            if touchedNode.name == "resetboarder" {
                resetButton.fontColor = .gray
                resetBoarder.strokeColor = .gray
            }
            if touchedNode.name == "tipthedevboarder" {
                tipTheDevButton.fontColor = .gray
                tipTheDevBoarder.strokeColor = .gray
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let pointOfTouch = touch.location(in: self)
            let touchedNode = self.atPoint(pointOfTouch)
            
            for i in 0..<numberOfGrids {
                if touchedNode == overlay[i] {
                    if !isPairConnected() {
                        lines[k].segment.removeAll()
                        removeLine(i: k)
                    }
                    isSolved()
                }
            }
            
            if solved && winLabel.name != "winlabel" {
                playSoundTada()
                popOverDialogue()
                print("Solved")
            }
            
            if touchedNode.name == "selectboardboarder" {
                selectBoardButton.fontColor = .white
                selectBoardBoarder.strokeColor = .white
                
                self.removeAllChildren()
                
                changeSceneToSelectBoard()
            }
            
            if touchedNode.name == "okboarder" {
                okButton.fontColor = .white
                okBoarder.strokeColor = .white
                
                changeSceneToEnd()
                self.removeAllChildren()
            }
            
            if touchedNode.name == "settingsbutton" && !solved {
                settingsButton.texture = SKTexture(imageNamed: "gear")
                pauseTimer = true
                popOverSettings()
            }
            if touchedNode.name == "backbutton" {
                backButton.texture = SKTexture(imageNamed: "back")
                popOver.removeFromParent()
            }
            if touchedNode.name == "reviewboarder" {
                reviewButton.fontColor = .white
                reviewBoarder.strokeColor = .white
                
                if let url = URL(string: "https://apps.apple.com/us/app/squiggles-10/id6448548321") {
                    UIApplication.shared.open(url)
                }
            }
            if touchedNode.name == "websiteboarder" {
                websiteButton.fontColor = .white
                websiteBoarder.strokeColor = .white
                
                if let url = URL(string: "https://glassoniongames.com") {
                    UIApplication.shared.open(url)
                }
            }
            if touchedNode.name == "resetboarder" {
                resetButton.fontColor = .white
                resetBoarder.strokeColor = .white
                
                showResetAlert(withTitle: "Reset Progress", message: "All data will be erased!")
            }
            if touchedNode.name == "tipthedevboarder" {
                tipTheDevButton.fontColor = .white
                tipTheDevBoarder.strokeColor = .white
                
                guard let theProduct = product else {
                    return
                }
                
                if SKPaymentQueue.canMakePayments() {
                    let payment = SKPayment(product: theProduct)
                    SKPaymentQueue.default().add(self)
                    SKPaymentQueue.default().add(payment)
                }
            }
        }
    }
                     
     func fetchProducts() {
         let request = SKProductsRequest(productIdentifiers: [productID])
         request.delegate = self
         request.start()
     }
     
     func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
         if let theProduct = response.products.first {
             product = theProduct
             print(product!.productIdentifier)
             print(product!.price)
             print(product!.localizedTitle)
             print(product!.localizedDescription)
         }
     }
     
     func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
         
         for transaction in transactions {
             switch transaction.transactionState {
                 
             case .purchasing: // no op
                 break
             case .purchased, .restored:
                 
                 SKPaymentQueue.default().finishTransaction(transaction)
                 SKPaymentQueue.default().remove(self)
                 
                 break
             case .failed, .deferred:
                 
                 print("Transaction has failed")
                 
                 break
             default: break
                 
                 
             }
         }
     }
    
    func changeSceneToSelectBoard() {
        
        let sceneToMoveTo = SelectBoardScene(size: self.size)
        let myTransition = SKTransition.fade(withDuration: 0.5)
        
        sceneToMoveTo.scaleMode = self.scaleMode
        
        self.view?.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func changeSceneToEnd() {
        
        load()
        
        let sceneToMoveTo = EndScene(size: self.size)
        let myTransition = SKTransition.fade(withDuration: 0.5)
        
        sceneToMoveTo.scaleMode = self.scaleMode
        
        self.view?.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func animateDot(i: Int) {
        
        let scaleIn = SKAction.scale(to: 1.3, duration: 0.3)
        let scaleOut = SKAction.scale(to: 1.0, duration: 0.3)
        let animation = SKAction.sequence([scaleIn, scaleOut])
        
        for j in 0..<numberOfGrids {
            if dot[j].fillColor == dot[i].fillColor {
                dot[j].run(animation)
            }
        }
    }
    
    func board() {
        
        grid.removeAll()
        dot.removeAll()
        overlay.removeAll()
        
        grid.forEach { gridRemove in
            gridRemove.removeFromParent()
        }
        dot.forEach { dotRemove in
            dotRemove.removeFromParent()
        }
        overlay.forEach { overlayRemove in
            overlayRemove.removeFromParent()
        }
        
        var rect = CGRect()
        
        rect.size.width = CGFloat(wH*boardSize)
        rect.size.height = CGFloat(wH*boardSize)
        rect.origin.x = size.width/2 - rect.width/2
        rect.origin.y = size.height/2 - rect.height/2 - CGFloat(wH)
        
        
        var x = rect.minX
        var y = rect.maxY
        
        for i in 0..<numberOfGrids {
            
            let mydot = dots.first { $0.dot == i }
            
            grid.append(SKShapeNode(rect: CGRect(x: 0, y: 0, width: wH, height: wH)))
            dot.append(SKShapeNode(circleOfRadius: CGFloat(wH/2) - 10*sizeRatio))
            overlay.append(SKShapeNode(rect: CGRect(x: 0, y: 0, width: wH, height: wH)))
            
            grid[i].position.x = x
            grid[i].position.y = y
            grid[i].fillColor = .clear
            grid[i].strokeColor = .white
            grid[i].zPosition = 1
            
            dot[i].position.x = x + CGFloat(wH/2)
            dot[i].position.y = y + CGFloat(wH/2)
            dot[i].fillColor = mydot?.color ?? .clear
            dot[i].strokeColor = .clear
            dot[i].zPosition = 2
            
            overlay[i].position.x = x
            overlay[i].position.y = y
            overlay[i].fillColor = .clear
            overlay[i].strokeColor = .clear
            overlay[i].zPosition = 4
            
            x += CGFloat(wH)
            
            addChild(grid[i])
            addChild(dot[i])
            addChild(overlay[i])
            
            // 6x6 Board
            if boardSize == 6 {
                if i == 5  { x = rect.minX; y = rect.maxY - CGFloat(wH*1) }
                if i == 11 { x = rect.minX; y = rect.maxY - CGFloat(wH*2) }
                if i == 17 { x = rect.minX; y = rect.maxY - CGFloat(wH*3) }
                if i == 23 { x = rect.minX; y = rect.maxY - CGFloat(wH*4) }
                if i == 29 { x = rect.minX; y = rect.maxY - CGFloat(wH*5) }
            }
            
            // 7x7 Board
            if boardSize == 7 {
                if i == 6  { x = rect.minX; y = rect.maxY - CGFloat(wH*1) }
                if i == 13 { x = rect.minX; y = rect.maxY - CGFloat(wH*2) }
                if i == 20 { x = rect.minX; y = rect.maxY - CGFloat(wH*3) }
                if i == 27 { x = rect.minX; y = rect.maxY - CGFloat(wH*4) }
                if i == 34 { x = rect.minX; y = rect.maxY - CGFloat(wH*5) }
                if i == 41 { x = rect.minX; y = rect.maxY - CGFloat(wH*6) }
            }
            
            // 8x8 Board
            if boardSize == 8 {
                if i == 7  { x = rect.minX; y = rect.maxY - CGFloat(wH*1) }
                if i == 15 { x = rect.minX; y = rect.maxY - CGFloat(wH*2) }
                if i == 23 { x = rect.minX; y = rect.maxY - CGFloat(wH*3) }
                if i == 31 { x = rect.minX; y = rect.maxY - CGFloat(wH*4) }
                if i == 39 { x = rect.minX; y = rect.maxY - CGFloat(wH*5) }
                if i == 47 { x = rect.minX; y = rect.maxY - CGFloat(wH*6) }
                if i == 55 { x = rect.minX; y = rect.maxY - CGFloat(wH*7) }
            }
            
            // 9x9 Board
            if boardSize == 9 {
                if i == 8  { x = rect.minX; y = rect.maxY - CGFloat(wH*1) }
                if i == 17 { x = rect.minX; y = rect.maxY - CGFloat(wH*2) }
                if i == 26 { x = rect.minX; y = rect.maxY - CGFloat(wH*3) }
                if i == 35 { x = rect.minX; y = rect.maxY - CGFloat(wH*4) }
                if i == 44 { x = rect.minX; y = rect.maxY - CGFloat(wH*5) }
                if i == 53 { x = rect.minX; y = rect.maxY - CGFloat(wH*6) }
                if i == 62 { x = rect.minX; y = rect.maxY - CGFloat(wH*7) }
                if i == 71 { x = rect.minX; y = rect.maxY - CGFloat(wH*8) }
            }
            
            // 10x10 Board
            if boardSize == 10 {
                if i == 9  { x = rect.minX; y = rect.maxY - CGFloat(wH*1) }
                if i == 19 { x = rect.minX; y = rect.maxY - CGFloat(wH*2) }
                if i == 29 { x = rect.minX; y = rect.maxY - CGFloat(wH*3) }
                if i == 39 { x = rect.minX; y = rect.maxY - CGFloat(wH*4) }
                if i == 49 { x = rect.minX; y = rect.maxY - CGFloat(wH*5) }
                if i == 59 { x = rect.minX; y = rect.maxY - CGFloat(wH*6) }
                if i == 69 { x = rect.minX; y = rect.maxY - CGFloat(wH*7) }
                if i == 79 { x = rect.minX; y = rect.maxY - CGFloat(wH*8) }
                if i == 89 { x = rect.minX; y = rect.maxY - CGFloat(wH*9) }
            }
        }
    }
    
    func randomizecolors() {
        for i in 0..<squiggles.count {
            squiggles[i].color = color[i]
        }
    }
    
    func save() {
        perfectGames = Int(NSUbiquitousKeyValueStore().double(forKey: "perfectGames\(boardSize)"))
        perfectStreak = Int(NSUbiquitousKeyValueStore().double(forKey: "perfectStreak\(boardSize)"))
        longestStreak = Int(NSUbiquitousKeyValueStore().double(forKey: "longestStreak\(boardSize)"))
        if message == "PERFECT!" {
            perfectGames += 1
            perfectStreak += 1
        } else {
            perfectStreak = 0
        }
        if perfectStreak > longestStreak {
            NSUbiquitousKeyValueStore().set(perfectStreak, forKey: "longestStreak\(boardSize)")
        }
        elapsedBest = Int(NSUbiquitousKeyValueStore().double(forKey: "elapsedBest\(boardSize)"))
        if elapsedBest == 0 {
            elapsedBest = elapsed
        }
        if elapsed <= elapsedBest {
            NSUbiquitousKeyValueStore().set(elapsed, forKey: "elapsedBest\(boardSize)")
        }
        NSUbiquitousKeyValueStore().set(perfectGames, forKey: "perfectGames\(boardSize)")
        NSUbiquitousKeyValueStore().set(perfectStreak, forKey: "perfectStreak\(boardSize)")
        NSUbiquitousKeyValueStore().set(message, forKey: "message\(boardSize)")
        NSUbiquitousKeyValueStore().set(time, forKey: "timeCurrent\(boardSize)")
        NSUbiquitousKeyValueStore().set(moves, forKey: "moves\(boardSize)")
        if GKLocalPlayer.local.isAuthenticated {
            GKLeaderboard.submitScore(elapsed, context: 0, player: GKLocalPlayer.local,
            leaderboardIDs: [leaderboardID], completionHandler: {
                error in
                
                if error != nil {
                    print(error!)
                } else {
                    print("Time: \(self.elapsed) submitted")
                }
            })
        }
    }
    
    func load() {
        sound = defaults.bool(forKey: "sound")
        moves = Int(NSUbiquitousKeyValueStore().double(forKey: "moves\(boardSize)"))
        perfectGames = Int(NSUbiquitousKeyValueStore().double(forKey: "perfectGames\(boardSize)"))
        perfectStreak = Int(NSUbiquitousKeyValueStore().double(forKey: "perfectStreak\(boardSize)"))
        longestStreak = Int(NSUbiquitousKeyValueStore().double(forKey: "longestStreak\(boardSize)"))
        message = NSUbiquitousKeyValueStore().string(forKey: "message\(boardSize)") ?? ""
        timeCurrent = NSUbiquitousKeyValueStore().string(forKey: "timeCurrent\(boardSize)") ?? ""
        elapsedBest = Int(NSUbiquitousKeyValueStore().double(forKey: "elapsedBest\(boardSize)"))
        timeBest = createTimeString(seconds: elapsedBest)
    }
    
    func drawDots() {
        for i in 0..<squiggles.count {
            dots.append(Dot(color: color[i], dot: squiggles[i].middle.first ?? 0))
            dots.append(Dot(color: color[i], dot: squiggles[i].middle.last ?? 0))
        }
    }
    
    func middle() {
        
        for i in 0..<squiggles.count {
            
            let lineToDraw = SKShapeNode()
            let path = CGMutablePath()
            
            path.move(to: position(at: squiggles[i].middle.first ?? 0))
            for j in 0..<squiggles[i].middle.count {
                path.addLine(to: position(at: squiggles[i].middle[j]))
            }
            lineToDraw.path = path
            lineToDraw.strokeColor = squiggles[i].color
            lineToDraw.lineWidth = 15*sizeRatio
            lineToDraw.zPosition = 3
            lineToDraw.name = "line"
            addChild(lineToDraw)
        }
    }
    
    func drawLine() {
        for i in 0..<lines.count {
            
            let lineToDraw = SKShapeNode()
            let path = CGMutablePath()
            
            path.move(to: position(at: lines[i].segment.first ?? 0))
            for j in 0..<lines[i].segment.count {
                path.addLine(to: position(at: lines[i].segment[j]))
            }
            lineToDraw.path = path
            lineToDraw.strokeColor = lines[i].color
            lineToDraw.lineWidth = 15*sizeRatio
            lineToDraw.zPosition = 3
            lineToDraw.name = String(i)
            addChild(lineToDraw)
        }
    }
    
    // Convert index to position
    func position(at index: Int) -> CGPoint {
        let row = index / rows
        let col = index % cols
        return CGPoint(x: CGFloat(col*wH) + dot[0].position.x, y: dot[0].position.y - CGFloat(row*wH))
    }
    
    func randomize() {
        for _ in 0..<100 {
            let rnd: Int = Int.random(in: 0..<squiggles.count)
            for i in 0..<squiggles.count {
                if squiggles[rnd].middle.count > 3 {
                    if isNeighbor(end1: squiggles[rnd].middle.first ?? 0, end2: squiggles[i].middle.first ?? 0) {
                        squiggles[i].middle.insert(squiggles[rnd].middle.first ?? 0, at: 0)
                        squiggles[rnd].middle.removeFirst()
                    }
                    if isNeighbor(end1: squiggles[rnd].middle.last ?? 9, end2: squiggles[i].middle.last ?? 9) {
                        squiggles[i].middle.append(squiggles[rnd].middle.last ?? 9)
                        squiggles[rnd].middle.removeLast()
                    }
                }
            }
        }
        randomizecolors()
        drawDots()
        moves = 0
    }
    
    func start(i: Int) {
        let dot = dots.first { $0.dot == i }
        for j in 0..<lines.count {
            if lines[j].color == dot?.color {
                k = j
            }
        }
    }
    
    func elapsedTime() {
        elapsed = 0
        time = "00:00"
        timer.invalidate()
        if !timer.isValid {
            timer.fire()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
                if pauseTimer == false { elapsed += 1 }
                time = createTimeString(seconds: elapsed)
                timeLabel.text = "Time: \(time)"
            }
        } else {
            timer.invalidate()
        }
    }
    
    func createTimeString(seconds: Int) -> String {
        let m: Int = (seconds/60) % 60
        let s: Int = seconds % 60
        let a = String(format: "%02u:%02u", m, s)
        return a
    }
    
    func move(i: Int) {
        let dot = dots.first { $0.dot == i }
        if isWalkingBack(i: i) && !isConnected {
            lines[k].segment.removeLast()
            removeLine(i: k)
        }
        if isPairConnected() { return }
        if lines[k].segment.last != nil {
            if !isNeighbor(end1: lines[k].segment.last ?? 0, end2: i) {
                return
            }
        }
        if (dot != nil && lines[k].color == dot?.color) || (lines[k].segment.last != nil && dot == nil) {
            lines[k].segment.append(i)
        }
        if hasDuplicateLines(in: lines) {
            lines[k].segment.removeLast()
            removeLine(i: k)
            //            deleteIntersectedLine(i: i)
        }
    }
    
    func isWalkingBack(i: Int) -> Bool {
        if lines[k].segment.contains(i) {
            return true
        }
        return false
    }
    
    func deleteLine(i: Int) {
        for j in 0..<lines.count {
            if lines[j].segment.contains(i) {
                lines[j].segment.removeAll()
                removeLine(i: j)
            }
        }
    }
    
    func removeLine(i: Int) {
        self.children
            .filter { $0.name == String(i)}
            .forEach { node in
                node.removeFromParent()
            }
    }
    
    func deleteIntersectedLine(i: Int) {
        for j in 0..<lines.count {
            if lines[j].segment.contains(i) {
                for i in 0..<squiggles.count {
                    if (lines[j].segment.first == squiggles[i].middle.first &&
                        lines[j].segment.last  == squiggles[i].middle.last) ||
                        (lines[j].segment.first == squiggles[i].middle.last  &&
                         lines[j].segment.last  == squiggles[i].middle.first) {
                        lines[j].segment.removeAll()
                    }
                }
            }
        }
    }
    
    func isPairConnected() -> Bool {
        for i in 0..<squiggles.count {
            if (lines[k].segment.first == squiggles[i].middle.first &&
                lines[k].segment.last  == squiggles[i].middle.last) ||
                (lines[k].segment.first == squiggles[i].middle.last  &&
                 lines[k].segment.last  == squiggles[i].middle.first) {
                return true
            }
        }
        return false
    }
    
    func countMoves(i: Int) {
        if !isConnected {
            if isPairConnected() {
                isConnected = true
                let dot = dots.first { $0.dot == i }
                if dot?.color != lastDotColor {
                    moves += 1
                    movesLabel.text = "Moves: \(moves) of \(boardSize)"
                    lastDotColor = dot?.color ?? .clear
                }
                if moves <= boardSize {
                    message = "PERFECT!"
                } else {
                    message = "SOLVED!"
                }
                playSoundMove()
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                impactHeavy.impactOccurred()
            }
        } else if !isPairConnected() {
            isConnected = false
        }
    }
    
    func playSoundMove() {
        do {
            let url =  Bundle.main.url(forResource: "move", withExtension: "mp3")
            soundPlayer = try AVAudioPlayer(contentsOf: url!)
            soundPlayer?.volume = 0.5
            soundPlayer?.prepareToPlay()
            if sound == true { soundPlayer?.play() }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSoundTada() {
        do {
            let url =  Bundle.main.url(forResource: "tada", withExtension: "mp3")
            soundPlayer = try AVAudioPlayer(contentsOf: url!)
            soundPlayer?.volume = 0.2
            soundPlayer?.prepareToPlay()
            if sound == true { soundPlayer?.play() }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func hasDuplicateLines(in lines: [Line]) -> Bool {
        var set = Set<Int>()
        for line in lines {
            for integer in line.segment {
                if set.contains(integer) {
                    return true
                } else {
                    set.insert(integer)
                }
            }
        }
        return false
    }
    
    func isNeighbor(end1: Int, end2: Int) -> Bool {
        if boardSize == 6 {
            if ( abs(end1 - end2) == 1 || abs(end1 - end2) == 6 ) &&
                !(end1 == 0  && end2 == 11) && !(end2 ==  0 && end1 == 11) &&
                !(end1 == 6  && end2 ==  5) && !(end2 ==  6 && end1 ==  5) &&
                !(end1 == 12 && end2 == 11) && !(end2 == 12 && end1 == 11) &&
                !(end1 == 18 && end2 == 17) && !(end2 == 18 && end1 == 17) &&
                !(end1 == 24 && end2 == 23) && !(end2 == 24 && end1 == 23) &&
                !(end1 == 30 && end2 == 29) && !(end2 == 30 && end1 == 29) {
                return true
            }
        } else if boardSize == 7 {
            if ( abs(end1 - end2) == 1 || abs(end1 - end2) == 7 ) &&
                !(end1 == 0  && end2 == 13) && !(end2 ==  0 && end1 == 13) &&
                !(end1 == 7  && end2 ==  6) && !(end2 ==  7 && end1 ==  6) &&
                !(end1 == 14 && end2 == 13) && !(end2 == 14 && end1 == 13) &&
                !(end1 == 21 && end2 == 20) && !(end2 == 21 && end1 == 20) &&
                !(end1 == 28 && end2 == 27) && !(end2 == 28 && end1 == 27) &&
                !(end1 == 35 && end2 == 34) && !(end2 == 35 && end1 == 34) &&
                !(end1 == 42 && end2 == 41) && !(end2 == 42 && end1 == 41) {
                return true
            }
        } else if boardSize == 8 {
            if ( abs(end1 - end2) == 1 || abs(end1 - end2) == 8 ) &&
                !(end1 == 0  && end2 == 15) && !(end2 ==  0 && end1 == 15) &&
                !(end1 == 8  && end2 ==  7) && !(end2 ==  8 && end1 ==  7) &&
                !(end1 == 16 && end2 == 15) && !(end2 == 16 && end1 == 15) &&
                !(end1 == 24 && end2 == 23) && !(end2 == 24 && end1 == 23) &&
                !(end1 == 32 && end2 == 31) && !(end2 == 32 && end1 == 31) &&
                !(end1 == 40 && end2 == 39) && !(end2 == 40 && end1 == 39) &&
                !(end1 == 48 && end2 == 47) && !(end2 == 48 && end1 == 47) &&
                !(end1 == 56 && end2 == 55) && !(end2 == 56 && end1 == 55) {
                return true
            }
        } else if boardSize == 9 {
            if ( abs(end1 - end2) == 1 || abs(end1 - end2) == 9 ) &&
                !(end1 == 0  && end2 == 17) && !(end2 ==  0 && end1 == 17) &&
                !(end1 == 9  && end2 ==  8) && !(end2 ==  9 && end1 ==  8) &&
                !(end1 == 18 && end2 == 17) && !(end2 == 18 && end1 == 17) &&
                !(end1 == 27 && end2 == 26) && !(end2 == 27 && end1 == 26) &&
                !(end1 == 36 && end2 == 35) && !(end2 == 36 && end1 == 35) &&
                !(end1 == 45 && end2 == 44) && !(end2 == 45 && end1 == 44) &&
                !(end1 == 54 && end2 == 53) && !(end2 == 54 && end1 == 53) &&
                !(end1 == 63 && end2 == 62) && !(end2 == 63 && end1 == 62) &&
                !(end1 == 72 && end2 == 71) && !(end2 == 72 && end1 == 71) {
                return true
            }
        } else if boardSize == 10 {
            if ( abs(end1 - end2) == 1 || abs(end1 - end2) == 10 ) &&
                !(end1 == 0  && end2 == 19) && !(end2 ==  0 && end1 == 19) &&
                !(end1 == 10 && end2 ==  9) && !(end2 == 10 && end1 ==  9) &&
                !(end1 == 20 && end2 == 19) && !(end2 == 20 && end1 == 19) &&
                !(end1 == 30 && end2 == 29) && !(end2 == 30 && end1 == 29) &&
                !(end1 == 40 && end2 == 39) && !(end2 == 40 && end1 == 39) &&
                !(end1 == 50 && end2 == 49) && !(end2 == 50 && end1 == 49) &&
                !(end1 == 60 && end2 == 59) && !(end2 == 60 && end1 == 59) &&
                !(end1 == 70 && end2 == 69) && !(end2 == 70 && end1 == 69) &&
                !(end1 == 80 && end2 == 79) && !(end2 == 80 && end1 == 79) &&
                !(end1 == 90 && end2 == 89) && !(end2 == 90 && end1 == 89) {
                return true
            }
        } else {
            return false
        }
        return false
    }
    
    func isSolved() {
        var count: Int = 0
        for line in lines {
            for integer in line.segment {
                if integer >= 0 && integer <= numberOfGrids {
                    count += 1
                }
            }
        }
        if count == numberOfGrids {
            solved = true
            save()
            timer.invalidate()
        }
    }
}

struct GameSceneView: View {
    
    var body: some View {
        SpriteView(scene: GameScene(size:CGSize(width: gameWidth, height: gameHeight)))
            .ignoresSafeArea()
    }
}

#Preview {
    GameSceneView()
}
