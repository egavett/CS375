//
//  GameGrid.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-07.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class GameGrid: UIView {
    var gridArray = [[GridPoint]]() {
        didSet {
            // Update the subviews to reflect the change
            for view in self.subviews {
                // Get the view's gridpoint's x/y values
                let x = (view as! GridSquare).gridPoint?.x
                let y = (view as! GridSquare).gridPoint?.y
                
                // Set the the appropriate gridPoint
                (view as! GridSquare).gridPoint = gridArray[x!][y!]
            }
            // DEBUG: Update the grid color
            updateGridColors()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set the gridArray size to be 10x10
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Calculate the cell width and height
        let cellWidth:CGFloat = self.frame.width / 10.0
        let cellHeight:CGFloat = self.frame.height / 10.0
        
        // Counter variable for cell x and y position
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        // Create cells
        for i in 0...9 {
            // Next row to append to the gridArray
            var nextRow = [GridPoint]()
            
            for j in 0...9 {
                // Create the cell
                let point = GridPoint(x: Int(i), y: Int(j))
                let gridSquare = GridSquare(frame: CGRectMake(x, y, cellWidth, cellHeight), gp: point)
                
                // Set the display properties
                gridSquare.backgroundColor = UIColor.blueColor()
                gridSquare.layer.borderWidth = 1.0
                gridSquare.layer.borderColor = UIColor.darkGrayColor().CGColor
                
                
                // Add the square to the view hierarchy and the gridsquare array
                self.addSubview(gridSquare)
                nextRow.append(gridSquare.gridPoint!)
                
                // Increment x
                x += cellWidth
            }
            // Apend the row to the main array
            gridArray.append(nextRow)
            
            // Reset x, increment y
            x = 0
            y += cellHeight
        }
    }
    
    // MARK: External Updates
    
    func updateGridArray() {
        // Ennumerate through each subview
        for view in self.subviews {
            // Cast view as a GridSquare
            let gridSquare = (view as! GridSquare)
            
            // Get gridSquare's x/y values
            let x = gridSquare.gridPoint?.x
            let y = gridSquare.gridPoint?.y
            
            // Update gridSquare's gridPoint to reflect the value in the gridArray
            gridSquare.gridPoint = gridArray[x!][y!]
        }
    }
    
    /// Updates the subviews to reflect the status of the board
    func updateGridColors() -> () {
        // Enumerate through each view
        for gridSquare in self.subviews {
            // Yellow border for occupied squres
            if(gridSquare as! GridSquare).gridPoint?.occupied == true {
                gridSquare.layer.borderColor = UIColor.yellowColor().CGColor
            } else {
                gridSquare.layer.borderColor = UIColor.grayColor().CGColor
            }
            
            // If the square has been attacked...
            if (gridSquare as! GridSquare).gridPoint?.attacked == true {
                // Green if it was occupied, red if not
                if (gridSquare as! GridSquare).gridPoint?.occupied == true {
                    gridSquare.backgroundColor = UIColor.greenColor()
                } else {
                    gridSquare.backgroundColor = UIColor.redColor()
                }
            } else  {
                // Otherwise, set the color to blue
                gridSquare.backgroundColor = UIColor.blueColor()
            }
            
        }
    }
}
