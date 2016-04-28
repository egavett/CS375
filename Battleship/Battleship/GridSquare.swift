//
//  GridSquare.swift
//  Battleship
//
//  Created by Elijah L Gavett on 3/6/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class GridSquare: UIView {
    weak var gridPoint: GridPoint?
    var x: Int = -1
    var y: Int = -1
    
    init(frame: CGRect, gridPoint: GridPoint, x: Int, y: Int) {
        super.init(frame: frame)
        
        self.gridPoint = gridPoint
        self.x = x
        self.y = y
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    // Only override drawRect: if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//       // self.layer.borderColor = UIColor.blackColor().CGColor
//        //self.layer.borderWidth = 1.0
//    }

    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return CGRectContainsPoint(self.frame, point)
    }
}
