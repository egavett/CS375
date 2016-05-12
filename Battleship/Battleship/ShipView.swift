//
//  ShipView.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-08.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class ShipView: UIView {

    var ship: Ship?
    var placed: Bool = false
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return CGRectContainsPoint(self.frame, point)
    }
    
}
