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
        for i in 0 ..< 9 {
            for j in 0 ..< 9 {
                gameGrid[i][j] = GridPoint()
            }
        }
    }
}
