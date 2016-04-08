//
//  User.swift
//  Battleship
//
//  Created by Elijah L Gavett on 2/28/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class User: NSObject {
    var userName: String = ""
    var profilePicture: UIImage?
    var gamesWon: Int = 0
    var gamesPlayed: Int = 0
    var friendsList = [User]()
    
    init(userName: String){
        self.userName = userName
    }
    
    func addFriend(friend: User) {
        self.friendsList.append(friend)
    }
    
    func removeFriend(friend: User) {
        if self.friendsList.contains(friend) {
            self.friendsList.removeAtIndex(self.friendsList.indexOf(friend)!)
        }
    }
}
