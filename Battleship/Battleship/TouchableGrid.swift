//
//  TouchableGrid.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-09.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class TouchableGrid: UIView, UIGestureRecognizerDelegate {
    var selectedsquare: GridSquare?
    var gridArray = [[GridSquare]]() {
        didSet {
            // Update the subviews to reflect the change
            for view in self.subviews {
                // Get the view's gridpoint's x/y values
                let x = (view as! GridSquare).gridPoint?.x
                let y = (view as! GridSquare).gridPoint?.y
                
                // Set the the appropriate gridPoint
                (view as! GridSquare).gridPoint = gridArray[x!][y!].gridPoint
            }
            // DEBUG: Update the grid color
            updateGridColors()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Calculate the square width and height
        let squareWidth:CGFloat = self.frame.width / 10.0
        let squareHeight:CGFloat = self.frame.height / 10.0
        
        // Counter variable for square x and y position
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        // Create squares
        for i in 0...9 {
            // Next row to append to the gridArray
            var nextRow = [GridSquare]()
            
            for j in 0...9 {
                // Create the square
                let point = GridPoint(x: Int(i), y: Int(j))
                let gridSquare = GridSquare(frame: CGRectMake(x, y, squareWidth, squareHeight), gp: point)
                
                // Set the display properties
                gridSquare.backgroundColor = UIColor.whiteColor()
                gridSquare.layer.borderWidth = 1.0
                gridSquare.layer.borderColor = UIColor.blackColor().CGColor
                
                
                // Add the square to the view hierarchy and the gridsquare array
                self.addSubview(gridSquare)
                nextRow.append(gridSquare)
                
                // Increment x
                x += squareWidth
                
                // DEBUG: What is the x/y position
                print("At position:", i, j)
            }
            // Apend the row to the main array
            gridArray.append(nextRow)
            
            // Reset x, increment y
            x = 0
            y += squareHeight
        }
    }
    
    // MARK: Touch Handlers
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Get the location
        let t: UITouch = touches.first!
        let location: CGPoint = t.locationInView(self)
        
        self.selectedsquare?.layer.borderColor = UIColor.blackColor().CGColor
        self.selectedsquare?.layer.borderWidth = 1.0
        
        self.selectedsquare = self.squareAt(location)
        self.selectedsquare?.layer.borderColor = UIColor.redColor().CGColor
        self.selectedsquare?.layer.borderWidth = 2.0
        self.bringSubviewToFront(self.selectedsquare!)
        
    }
    
    /// Finds the corresponding square at a particular point
    func squareAt(point: CGPoint) -> GridSquare? {
        //for square in self.subviews as! Array<GridSquare> {
        for square in self.subviews {
            if square.dynamicType == GridSquare.self{
                if square.pointInside(point, withEvent: nil){
                    return (square as! GridSquare)
                }
            }
        }
        return nil
    }
    
    // MARK: Debugging
    func updateGridColors() -> () {
        for gridSquare in self.subviews {
            if (gridSquare as! GridSquare).gridPoint!.occupied == true{
                gridSquare.backgroundColor = UIColor.blueColor()
            } else {
                gridSquare.backgroundColor = UIColor.whiteColor()
            }
        }
    }
}






