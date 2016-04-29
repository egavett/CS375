//
//  GameGrid.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-07.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class GameGrid: UIView {
    var gridArray = [[GridSquare]]()
    
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
            var nextRow = [GridSquare]()
            
            for j in 0...9 {
                // Create the cell
                let point = GridPoint(x: Int(i), y: Int(j))
                let gridSquare = GridSquare(frame: CGRectMake(x, y, cellWidth, cellHeight), gp: point)
                
                // Set the display properties
                gridSquare.backgroundColor = UIColor.whiteColor()
                gridSquare.layer.borderWidth = 1.0
                gridSquare.layer.borderColor = UIColor.blackColor().CGColor
                
                
                // Add the square to the view hierarchy and the gridsquare array
                self.addSubview(gridSquare)
                nextRow.append(gridSquare)
                
                // Increment x
                x += cellWidth
                
                // DEBUG: What is the x/y position
                print("At position:", i, j)
            }
            // Apend the row to the main array
            gridArray.append(nextRow)
            
            // Reset x, increment y
            x = 0
            y += cellHeight
        }
    }
    
    // MARK: Debugging
    /// Sets unoccupied girdSquare backgrounds to white, occupied to blue
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
