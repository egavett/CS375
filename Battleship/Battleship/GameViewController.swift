//
//  GameViewController.swift
//  Battleship
//
//  Created by Elijah L Gavett on 3/6/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit
//import SpriteKit

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
//    var width: CGFloat!
//    var height: CGFloat = 9
//    var boxSize: CGFloat!
//    var gridStart: CGPoint!
    @IBOutlet weak var rotateButton: UIButton!
    @IBOutlet weak var gameGrid: GameGrid!
    @IBOutlet weak var beginButton: UIButton!
    weak var currentShip: ShipView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.view as! BackgroundView).gameGrid = gameGrid
        
        let x = 50
        let y = 450
        for i in 1...5 {
            // Create the shipView
            let ship = ShipView()
            
            // Create the ship's tap recognizer
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.selectShip(_:)))
            singleTap.delegate = self
            ship.addGestureRecognizer(singleTap)
            ship.tag = i
            
            // Create the ship's frame, initialize its ship property
            // There is no 1 square ship, but two 3 square ships
            if(i == 1) {
                ship.frame = CGRectMake(CGFloat(x) + CGFloat(i)*(self.view.frame.width/10.0+10.0), CGFloat(y), (self.view.frame.width/10.0), CGFloat(CGFloat(3)*(self.view.frame.width/10.0)))
                ship.ship = Ship(length: 3)
            } else {
                ship.frame = CGRectMake(CGFloat(x) + CGFloat(i)*(self.view.frame.width/10.0+10.0), CGFloat(y), (self.view.frame.width/10.0), CGFloat(CGFloat(i)*(self.view.frame.width/10.0)))
                ship.ship = Ship(length: i)
            }
            
            // Set appearance properties
            ship.backgroundColor = UIColor.redColor()
            ship.layer.borderColor = UIColor.blackColor().CGColor
            ship.layer.borderWidth = 1.0
            
            // Add the ship to the view hierarchy
            self.view.addSubview(ship)
        }
    }
    
    @IBAction func rotateCurrentShip(sender: AnyObject) {
        // Make sure we have the currentShip
        currentShip = (self.view as! BackgroundView).currentShip
        
        // If the ship is already on the grid, then set currentShip's squares to not-occupied
        if (currentShip?.ship?.front != nil) {
            (view as! BackgroundView).setCurrentShipSquaresTo(false)
        
            // Swap currentShip's horizontal property
            currentShip?.ship?.horizontal = !((currentShip?.ship?.horizontal)!)
        
            // See if the ship is still in a valid location
            if (self.view as! BackgroundView).isCurrentShipInValidGridPoint((currentShip?.ship!.front)!) {
                // Rotate the ship's frame
                currentShip?.frame = CGRectMake(currentShip!.frame.origin.x, currentShip!.frame.origin.y, currentShip!.frame.height, currentShip!.frame.width)
            } else {
                // Reset horizontal
                currentShip?.ship?.horizontal = !((currentShip?.ship?.horizontal)!)
            }
        
            // Set currentShip squares to occupied
            (view as! BackgroundView).setCurrentShipSquaresTo(true)
        } else {
            // Does not matter. Just rotate the frame and update horizontal
            currentShip?.frame = CGRectMake(currentShip!.frame.origin.x, currentShip!.frame.origin.y, currentShip!.frame.height, currentShip!.frame.width)
            currentShip?.ship?.horizontal = !((currentShip?.ship?.horizontal)!)
        }
    }
    
    func selectShip(sender: UIGestureRecognizer) {
        // Reset the old currentShip's color
        currentShip?.backgroundColor = UIColor.redColor()
        
        // Set the new currentShip
        currentShip = sender.view as? ShipView
        
        //Set the new currentShip color
        currentShip?.backgroundColor = UIColor.greenColor()
    }
    
    func checkShipStatus() -> Bool {
        // Check through each ship in the background
        for ship in self.view.subviews {
            if ship.dynamicType == ShipView.self{
                if (ship as! ShipView).placed == false {
                    return false
                }
            }
        }
        return true
    }
    
    
    // MARK: - Navigation
    @IBAction func startGame(sender: AnyObject) {
        // Only procede if the ships are placed
        if checkShipStatus() == true {
            // Store the gameData
            // Store the player's data
            GameData.playerGrid = gameGrid.gridArray
            
            /// FOR NOW: The computer will use the player's grid
            var tempArray = [[GridPoint]]()
            for row in 0..<10 {
                var nextRow = [GridPoint]()
                for col in 0..<10 {
                    nextRow.append(gameGrid.gridArray[row][col].copy())
                }
                tempArray.append(nextRow)
            }
            GameData.computerGrid = tempArray
            
            let mtgvc = MyTurnGameViewController()
            self.navigationController?.pushViewController(mtgvc, animated: true)
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Store the gameData
        // Store the player's data
        GameData.playerGrid = gameGrid.gridArray
        
        /// FOR NOW: The computer will use the player's grid
        var tempArray = [[GridPoint]]()
        for row in 0..<10 {
            var nextRow = [GridPoint]()
            for col in 0..<10 {
                nextRow.append(gameGrid.gridArray[row][col].copy())
            }
            tempArray.append(nextRow)
        }
        GameData.computerGrid = tempArray
    }
}
