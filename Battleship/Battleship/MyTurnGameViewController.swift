//
//  MyTurnGameViewController.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-09.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class MyTurnGameViewController: UIViewController {

    @IBOutlet weak var touchableGrid: TouchableGrid!
    @IBOutlet weak var gameGrid: GameGrid!
    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var yourLabel: UILabel!
    @IBOutlet weak var opponentLabel: UILabel!
    
    /// Determines what state the game is in. Return 'true' if the player can take thier turn
    var isPlayerTurn: Bool = true
    /// The player's score
    var playerScore: Int = 0 {
        didSet {
            if (playerScore >= 17) {
                // Set the game's outcome
                GameData.playerDidWin = true
                
                performSegueWithIdentifier("GameDidEnd", sender: nil)
            }
        }
    }
    /// The computer's score
    var computerScore: Int = 0 {
        didSet {
            if (computerScore >= 17) {
                // Set the game's outcome
                GameData.playerDidWin = false
                
                performSegueWithIdentifier("GameDidEnd", sender: nil)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set each grid's data
        touchableGrid.gridArray = GameData.computerGrid
        gameGrid.gridArray = GameData.playerGrid
        
        // Set the right views to be visable
        updateViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Gameplay
    func updateViews() {
        // Hid/Unhid views depending on gamestate
        if (self.isPlayerTurn == true) {
            touchableGrid.hidden = false
            gameGrid.hidden = true
            fireButton.hidden = false
            nextButton.hidden = true
            yourLabel.hidden = false
            opponentLabel.hidden = true
            
            // Reenable the button
            fireButton.enabled = true
            
        } else  {
            touchableGrid.hidden = true
            gameGrid.hidden = false
            fireButton.hidden = true
            nextButton.hidden = false
            yourLabel.hidden = true
            opponentLabel.hidden = false
            
            // It is the computer's turn. Call the appropriate method
            computerWillFire()
        }
    }
    
    @IBAction func playerWillFire(sender: AnyObject) {
        // Get the selected girdSquare, if it exists
        if (touchableGrid.selectedsquare != nil){
            let selectedSquare: GridSquare = touchableGrid.selectedsquare!
        
            // Only fire if gridSquare as not beed attacked yet
            if (selectedSquare.gridPoint?.attacked == false) {
                // Update the attacked property
                selectedSquare.gridPoint?.attacked = true
            
                // Update the square color based on occupied status
                if (selectedSquare.gridPoint?.occupied == true) {
                    selectedSquare.backgroundColor = UIColor.greenColor()
                
                    // Update the player's score
                    playerScore += 1
                } else {
                    selectedSquare.backgroundColor = UIColor.redColor()
                }
            
                // Disable fireButton
                fireButton.enabled = false
            
                // Wait 1 second, then set isPlayerTurn to false
                delay(1.0, closure: {
                    self.isPlayerTurn = false
                    self.updateViews()
                })
            
            } else  {
                // Get UIView's currentColor
                let currentColor = selectedSquare.backgroundColor
            
                // Flash yellow to show that they already fired here
                UIView.animateWithDuration(0.25, animations: {
                    selectedSquare.backgroundColor = UIColor.yellowColor()
                    }, completion: { finished in
                        UIView.animateWithDuration(0.25, animations: {
                            selectedSquare.backgroundColor = currentColor
                        })
                    })
            }
        }
    }

    func computerWillFire() {
        var hasFired = false
        
        while (hasFired == false) {
            // Get random x/y values
            let x: Int = Int(arc4random_uniform(10))
            let y: Int = Int(arc4random_uniform(10))
            
            // DEBUG: where did they fire?
            print("Computer will fire at: (", x, ",", y, ")")
            
            // Get the selected square
            let selectedSquare: GridPoint = gameGrid.gridArray[x][y]
            
            if(selectedSquare.attacked == false) {
                // Update the attacked property
                selectedSquare.attacked = true
                
                // If the square was occupied, add to the computer's score
                if (selectedSquare.occupied == true) {
                    computerScore += 1
                }
                
                // Update the grid colors
                gameGrid.updateGridColors()
                
                // Set hasFired to true
                hasFired = true
            }
        }
    }
    
    @IBAction func willBePlayersTurn(sender: AnyObject) {
        // Set isPlayersTurn to true
        self.isPlayerTurn = true
        updateViews()
    }
    
    // MARK: Delay
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
