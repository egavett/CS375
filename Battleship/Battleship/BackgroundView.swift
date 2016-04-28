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
        //for ship in self.subviews as! Array<ShipView> {
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
        if (gr.state == UIGestureRecognizerState.Changed){
            if self.currentShip != nil {
                let translation = gr.translationInView(self)
                var newLocation = self.currentShip!.frame.origin
            
                newLocation.x += translation.x
                newLocation.y += translation.y
                
                self.currentShip!.frame = CGRectMake(newLocation.x, newLocation.y, self.currentShip!.frame.width, self.currentShip!.frame.height)
            
                self.setNeedsDisplay()
                gr.setTranslation(CGPointZero, inView: self)
            }
        } else if (gr.state == UIGestureRecognizerState.Ended) {
            if self.currentShip != nil {
                // Find the distance from the currentShip to the first gridSquare
                var closeGrid: GridSquare = self.gameGrid?.subviews[0] as! GridSquare
                var closeDistance = distanceFromView(self.currentShip!, toView: (self.gameGrid?.subviews[0])!)
                for gridSquare in (self.gameGrid?.subviews)! {
                    let newDistance = distanceFromView(self.currentShip!, toView: gridSquare)
                    if (closeDistance >= newDistance) {
                        closeGrid = gridSquare as! GridSquare
                        closeDistance = newDistance
                    }
                }
                
                // Check if currentShip's position is valid
                if (isCurrentShipInValidGridSquare(closeGrid)) {
                    // Some helper varibles to make life a little easier
                    let xAxis = closeGrid.x
                    let yAxis = closeGrid.y
                    let length: Int = (currentShip!.ship?.length)!
                    
                    // Set currentShip's previously occupied squares to not occupied
                    if (currentShip?.ship?.front != nil) {
                        if (currentShip?.ship?.horizontal == true) {
                            for x in 0...length {
                                gameGrid?.gridArray[xAxis + x][yAxis].gridPoint?.occupied = false
                            }
                        } else {
                            for y in 0...length {
                                gameGrid?.gridArray[xAxis][yAxis + y].gridPoint?.occupied = false
                            }
                        }
                    }
                    
                    // Set currentShip's front
                    currentShip?.ship?.front = closeGrid.gridPoint
                    
                    // Set applicable squares to occupied
                    if (currentShip?.ship?.horizontal == true) {
                        // Set the affected squares to occupied
                        for x in 0...length {
                            gameGrid?.gridArray[xAxis + x][yAxis].gridPoint?.occupied = true
                        }
                        
                    } else {
                        // Set the affected squares to occupied
                        for y in 0...length {
                            gameGrid?.gridArray[xAxis][yAxis + y].gridPoint?.occupied = true
                        }
                    }
                    
                    // Move currentShip to the closest gridSquare
                    UIView.animateWithDuration(0.3333, animations: {
                        let frame = closeGrid.convertRect((closeGrid.bounds), toView: self.superview)
                        self.currentShip?.frame.origin = frame.origin
                    })
                }
            }
        }
    }
    
    /// Returns true if the ship is placed in a valid position
    func isCurrentShipInValidGridSquare(gridSquare: GridSquare) -> Bool {
        // Get the x/y position of the gridSquare, plus the length of the ship
        let xAxis = gridSquare.x
        let yAxis = gridSquare.y
        let length: Int = (currentShip!.ship?.length)!
        
        // Incrementation direction based on horizontal property
        if (currentShip!.ship?.horizontal == true) {
            // Check every space that the ship covers
            for x in 0...length {
                // If the square is outside the grid, return false
                if (xAxis + x) > 9 { return false }
                
                // If the square is occupied, return false
                if (gameGrid?.gridArray[xAxis + x][yAxis].gridPoint?.occupied == true){ return false }
            }
        } else {
            // Check every space that the ship covers
            for y in 0...length {
                // If the square is outside the grid, return false
                if (yAxis + y) > 9 { return false }
                
                // If the square is occupied, return false
                if (gameGrid?.gridArray[xAxis][yAxis + y].gridPoint?.occupied == true){ return false }
            }
        }
        
        // All conditions satisfied. Return true.
        return true
    }
    
    
    /// Finds the distance between the origins of two views using the distance formula
    func distanceFromView(view1: UIView, toView view2: UIView) -> Float {
        let distanceX: Double = Double(view2.frame.origin.x - view1.frame.origin.x)
        let distanceY: Double = Double(view2.frame.origin.y - view1.frame.origin.y)
        return sqrt(Float(pow(distanceX, 2) + pow(distanceY, 2)));
    }
}
