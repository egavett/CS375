//
//  GameGrid.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-07.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class GameGrid: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
//        // Drawing code
//        let ctx = UIGraphicsGetCurrentContext()
//        
//        let cellWidth:CGFloat = self.frame.width / 10.0
//        let cellHeight:CGFloat = self.frame.height / 10.0
//        
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
        
        let cellWidth:CGFloat = self.frame.width / 10.0
        let cellHeight:CGFloat = self.frame.height / 10.0
        
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


}
