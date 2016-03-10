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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
