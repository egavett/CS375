//
//  Ship.swift
//  Battleship
//
//  Created by Elijah L Gavett on 2/28/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class Ship: NSObject {
    var front: GridPoint?
    var length: Int = -1
    var health: Array<Bool> = [] /// Return false if the ship secton has NOT been attacked
    var horizontal = false
    
    init(length: Int) {
        self.length = length
        for _ in 0...length {
            self.health.append(false)
        }
    }
}
