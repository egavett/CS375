//
//  BackgroundView.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-08.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class BackgroundView: UIView, UIGestureRecognizerDelegate {
    // MARK: Properties
    var currentShip: ShipView?
    var panRecognizer: UIPanGestureRecognizer?
    var gameGrid: GameGrid?
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.currentShip = nil
        
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: (#selector(BackgroundView.moveShip(_:))))
        self.panRecognizer?.delegate = self
        self.panRecognizer?.cancelsTouchesInView = false
        self.addGestureRecognizer(panRecognizer!)
        
        self.backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.currentShip = nil
        
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: (#selector(BackgroundView.moveShip(_:))))
        self.panRecognizer?.delegate = self
        self.panRecognizer?.cancelsTouchesInView = false
        self.addGestureRecognizer(panRecognizer!)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: Touch Handlers
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Get the location
        let t: UITouch = touches.first!
        let location: CGPoint = t.locationInView(self)
        
        self.currentShip?.backgroundColor = UIColor.redColor()
        
        self.currentShip = self.shipAt(location)
        self.currentShip?.backgroundColor = UIColor.greenColor()
        
    }
    
    func shipAt(point: CGPoint) -> ShipView? {
        for ship in self.subviews {
            if ship.dynamicType == ShipView.self{
                if ship.pointInside(point, withEvent: nil){
                    return (ship as! ShipView)
                }
            }
        }
        return nil
    }
    
    func moveShip(gr: UIPanGestureRecognizer) {
        if (gr.state == UIGestureRecognizerState.Began) {
            if self.currentShip != nil {
                // If the ship has been placed somewhere else before
                // Set currentShip's previously occupied squares to not occupied
                if (currentShip?.ship?.front != nil) {
                    setCurrentShipSquaresTo(false)
                }
                // Set ship's placed to false
                self.currentShip!.placed = false
            }
        } else if (gr.state == UIGestureRecognizerState.Changed){
            if self.currentShip != nil {
                // FInd the difference between where currentShip was and is
                let translation = gr.translationInView(self)
                var newLocation = self.currentShip!.frame.origin
                newLocation.x += translation.x
                newLocation.y += translation.y
                
                // Update currentShip's frame
                self.currentShip!.frame = CGRectMake(newLocation.x, newLocation.y, self.currentShip!.frame.width, self.currentShip!.frame.height)
                
                // Helper code
                self.setNeedsDisplay()
                gr.setTranslation(CGPointZero, inView: self)
            }
        } else if (gr.state == UIGestureRecognizerState.Ended) {
            if self.currentShip != nil {
                // Find the distance from the currentShip to the first gridSquare
                var closeGrid: GridSquare = self.gameGrid?.subviews[0] as! GridSquare
                var closeDistance = distanceFromView(self.currentShip!, toView: (self.gameGrid?.subviews[0])!)
                
                // If the ship is closer to another gridSquare, set that as the closest gridSquare
                for gridSquare in (self.gameGrid?.subviews)! {
                    let newDistance = distanceFromView(self.currentShip!, toView: gridSquare)
                    if (closeDistance >= newDistance) {
                        closeGrid = gridSquare as! GridSquare
                        closeDistance = newDistance
                    }
                }
                
                // Check if currentShip's position is valid
                if (isCurrentShipInValidGridPoint(closeGrid.gridPoint!)) {
                    // Set currentShip's front
                    currentShip?.ship?.front = closeGrid.gridPoint
                    
                    // Set applicable squares to occupied
                    setCurrentShipSquaresTo(true)
                    
                    // Set currentShip's placed to true
                    self.currentShip!.placed = true
                    
                    // Move currentShip to the closest gridSquare
                    UIView.animateWithDuration(0.3333, animations: {
                        let frame = closeGrid.convertRect((closeGrid.bounds), toView: nil)
                        self.currentShip?.frame.origin = frame.origin
                    })
                }
            }
        }
    }
    
    /// Sets all the squares underneath the ship to true or false, based on horizontal
    func setCurrentShipSquaresTo(bool: Bool) -> () {
        // Get the indexes of the front of the ship, as well as the length
        let xAxis:Int = (currentShip?.ship?.front?.x)!
        let yAxis:Int = (currentShip?.ship?.front?.y)!
        let length: Int = (currentShip?.ship?.length)!
        
        // Direction of iteration based upon currentShip's horizontal
        if (currentShip?.ship?.horizontal == false) {
            // Make sure currentShip is within bounds
            if(xAxis + length <= 10) {
                for x in 0..<length {
                    gameGrid?.gridArray[xAxis + x][yAxis].occupied = bool
                }
            }
        } else {
            // Make sure currentShip is within bounds
            if(yAxis + length <= 10) {
                for y in 0..<length {
                    gameGrid?.gridArray[xAxis][yAxis + y].occupied = bool
                }
            }
        }
        // Update gameGrid's subViews
        gameGrid?.updateGridArray()
        
        // Update the gameGrid colors
        gameGrid?.updateGridColors()
    }

    /// Returns true if the ship is placed in a valid position
    func isCurrentShipInValidGridPoint(gridPoint: GridPoint) -> Bool {
        // Get the x/y position of the gridSquare, plus the length of the ship
        let xAxis = gridPoint.x
        let yAxis = gridPoint.y
        let length: Int = (currentShip!.ship?.length)!
        
        // Incrementation direction based on horizontal property
        if (currentShip!.ship?.horizontal == false) {
            // Check every space that the ship covers
            for x in 0..<length {
                // If the square is outside the grid, return false
                if (xAxis + x) > 9 { return false }
                
                // If the square is occupied, return false
                if (gameGrid?.gridArray[xAxis + x][yAxis].occupied == true){ return false }
            }
        } else {
            // Check every space that the ship covers
            for y in 0..<length {
                // If the square is outside the grid, return false
                if (yAxis + y) > 9 { return false }
                
                // If the square is occupied, return false
                if (gameGrid?.gridArray[xAxis][yAxis + y].occupied == true){ return false }
            }
        }
        
        // All conditions satisfied. Return true.
        return true
    }
    
    /// Finds the distance between the origins of two views using the distance formula
    func distanceFromView(view1: UIView, toView view2: UIView) -> Float {
        // Distance formula
        let distanceX: Double = Double(view2.frame.origin.x - view1.frame.origin.x)
        let distanceY: Double = Double(view2.frame.origin.y - view1.frame.origin.y)
        return sqrt(Float(pow(distanceX, 2) + pow(distanceY, 2)));
    }
}
