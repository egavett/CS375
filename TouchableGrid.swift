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
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing Grid
        
        let cellWidth:CGFloat = self.frame.width / 10.0
        let cellHeight:CGFloat = self.frame.height / 10.0
        
//        let ctx = UIGraphicsGetCurrentContext()
//        for (var x:CGFloat = 0.0; x < rect.size.width; x += cellWidth){
//            CGContextBeginPath(ctx)
//            CGContextMoveToPoint(ctx, x, 0)
//            CGContextAddLineToPoint(ctx, x, rect.size.height)
//            CGContextSetLineWidth(ctx, 1)
//            UIColor.blackColor().setStroke()
//            CGContextStrokePath(ctx)
//        }
//        
//        for (var y:CGFloat = 0.0; y < rect.size.height; y += cellHeight){
//            CGContextBeginPath(ctx)
//            CGContextMoveToPoint(ctx, 0, y)
//            CGContextAddLineToPoint(ctx, rect.size.width, y)
//            CGContextSetLineWidth(ctx, 1)
//            UIColor.blackColor().setStroke()
//            CGContextStrokePath(ctx)
//        }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        let TESTPOINT = GridPoint()
        
        // Create cells
        for _ in 0...9 {
            for _ in 0...9 {
                let gridCell = GridSquare(frame: CGRectMake(x, y, cellWidth, cellHeight), gridPoint: TESTPOINT)
                gridCell.backgroundColor = UIColor.whiteColor()
                gridCell.layer.borderWidth = 1.0
                gridCell.layer.borderColor = UIColor.blackColor().CGColor
                
                self.addSubview(gridCell)

                x += cellWidth
            }
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






