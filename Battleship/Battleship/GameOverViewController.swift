//
//  GameOverViewController.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-05-11.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    @IBOutlet weak var outcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(GameData.playerDidWin == true) {
            outcomeLabel.text = "You vanquished the computer!"
        } else {
            outcomeLabel.text = "Sorry. You lost."
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
