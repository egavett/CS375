//
//  SettingsMenuViewController.swift
//  Battleship
//
//  Created by Elijah L Gavett on 2/28/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class SettingsMenuViewController: UIViewController {
    
    @IBOutlet weak var musicLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var gamesWonLabel: UILabel!
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = PFUser.currentUser()
        
        let query = PFQuery(className: "gameStats")
        
        query.whereKey("user", equalTo: currentUser!)
        query.getFirstObjectInBackgroundWithBlock( {(stats, error) in
            if (error != nil) {
                print(error?.localizedDescription)
            } else {
                self.gamesWonLabel.text = (stats?.objectForKey("gamesWon") as? String)
                self.gamesPlayedLabel.text = (stats?.objectForKey("gamesPlayed") as? String)
                print("Labels should be updated")
            }
            
            
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleMusic(sender: UISwitch) {
        if sender.on {
            self.musicLabel.text = "Music Enabled"
        } else {
            self.musicLabel.text = "Music Disabled"
         }
    }
    
    @IBAction func toggleSound(sender: UISwitch) {
        if sender.on {
            self.soundLabel.text = "Sound Enabled"
        } else {
            self.soundLabel.text = "Sound Disabled"
        }
    }
    
    @IBAction func changeUsername(sender: AnyObject) {
        // Get the users new username and the current user
        let newUsername = self.usernameField.text
        let currentUser = PFUser.currentUser()
        
        // Change the username
        currentUser?.username = newUsername
        
        // Update on Parse
        currentUser?.saveInBackgroundWithBlock( { (user, error) in
            if (error != nil)
            {
                print(error?.localizedDescription)
            }
            else
            {
                print("Successful login")
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
