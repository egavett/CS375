//
//  GridPoint.swift
//  Battleship
//
//  Created by Elijah L Gavett on 2/28/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class GridPoint: NSObject {
    var occupied: Bool = false
    var attacked: Bool = false
    
    /// Returns true if the point has not been attacked AND the point is occupied
    func attackPoint() -> Bool {
        // Check if the square has already been attacked
        if !attacked {
            attacked = true
            // Return point status
            return occupied
        } else {
            // Maybe in future this will throw an exception
            return false
        }
    }
}