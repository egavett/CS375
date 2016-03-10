//
//  Grid.swift
//  Battleship
//
//  Created by Elijah L Gavett on 2/28/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class Grid: NSObject {
    var gameGrid = Array<Array<GridPoint>>()
    
    override init() {
        super.init()
        // Create a 10x10 grid
        for var i = 0; i < 9; i++ {
            for var j = 0; j < 9; j++ {
                gameGrid[i][j] = GridPoint()
            }
        }
    }
    
    
    
}
