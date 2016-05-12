//
//  GridPoint.swift
//  Battleship
//
//  Created by Elijah L Gavett on 2/28/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class GridPoint: NSObject, Copying {
    var occupied: Bool = false
    var attacked: Bool = false
    var x: Int = -1
    var y: Int = -1
    
    init(x: Int, y: Int) {
        super.init()
        self.x = x
        self.y = y
    }
    
    required init(original: GridPoint) {
        occupied = original.occupied
        attacked = original.attacked
        x = original.x
        y = original.y
        
    }
}
