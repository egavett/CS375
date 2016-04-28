//
//  TouchableGrid.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-09.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class TouchableGrid: UIView, UIGestureRecognizerDelegate {
    var selectedCell: GridSquare?
    var gridArray = [[GridSquare]]()
    
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
            for j in 0...9 {
                // Create the cell
                let gridCell = GridSquare(frame: CGRectMake(x, y, cellWidth, cellHeight), gridPoint: GridPoint(), x: i, y: j)
                
                // Set the display properties
                gridCell.backgroundColor = UIColor.whiteColor()
                gridCell.layer.borderWidth = 1.0
                gridCell.layer.borderColor = UIColor.blackColor().CGColor
                
                // Add the cell to the view hierarchy and the gridsquare array
                self.addSubview(gridCell)
                gridArray[i][j] = gridCell
                
                // Increment x
                x += cellWidth
            }
            // Reset x, increment y
            x = 0
            y += cellHeight
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Get the location
        let t: UITouch = touches.first!
        let location: CGPoint = t.locationInView(self)
        
        self.selectedCell?.layer.borderColor = UIColor.blackColor().CGColor
        self.selectedCell?.layer.borderWidth = 1.0
        
        self.selectedCell = self.cellAt(location)
        self.selectedCell?.layer.borderColor = UIColor.redColor().CGColor
        self.selectedCell?.layer.borderWidth = 2.0
        self.bringSubviewToFront(self.selectedCell!)
        
    }
    
    func cellAt(point: CGPoint) -> GridSquare? {
        //for cell in self.subviews as! Array<GridSquare> {
        for cell in self.subviews {
            if cell.dynamicType == GridSquare.self{
                if cell.pointInside(point, withEvent: nil){
                    return (cell as! GridSquare)
                }
            }
        }
        return nil
    }
}






