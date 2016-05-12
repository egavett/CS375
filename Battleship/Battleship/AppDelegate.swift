//
//  AppDelegate.swift
//  Battleship
//
//  Created by Elijah L Gavett on 2/28/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // Initialize Parse
//        Parse.initializeWithConfiguration(ParseClientConfiguration{ (config) in
//            config.applicationId = "f1b626b8-cbb4-4dc7-b973-e98b2fa4de02"
//            config.clientKey = " "
//            config.server = "http://cs375bship.azurewebsites.net/parse"
//        })
        

        
//        PFUser.logInWithUsernameInBackground("MyNewUsername", password: "strongPassword", block: { (user, error) in
//            if (error != nil)
//            {
//                print(error?.localizedDescription)
//            }
//            else
//            {
//                print("Successful login")
//            }
//        })
        
//        let testUser = PFUser.currentUser()
//        
//        let gameStats = PFObject(className: "gameStats")
//        gameStats.setObject(testUser!, forKey: "user")
//        gameStats.setObject(4, forKey: "gamesPlayed")
//        gameStats.setObject(1, forKey: "gamesWon")
//        gameStats.saveInBackgroundWithBlock({ (success, error) in
//            if (error != nil)
//            {
//                print(error?.localizedDescription);
//            }
//            else
//            {
//                print("Successfully saved")
//            }
//        })
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

/// A global structure that will contain the data for the player's data the computer's data during gameplay
struct GameData {
    /// The player's grid
    static var playerGrid = [[GridPoint]]()
    /// The computer's grid
    static var computerGrid = [[GridPoint]]()
    
    /// The outcome of the game
    static var playerDidWin: Bool?
}

/// Custom protocol that allows objects to be deep copied
protocol Copying {
    init(original: Self)
}

extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}

