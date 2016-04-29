//
//  MyTurnGameViewController.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-09.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class MyTurnGameViewController: UIViewController {

    @IBOutlet weak var touchableGrid: TouchableGrid!
    /// Helper Variable to pass data along
    var gridArray = [[GridSquare]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        touchableGrid.gridArray = self.gridArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playerWillFire(sender: AnyObject) {
        // Get the selected girdSquare
        let selectedSquare: GridSquare = touchableGrid.selectedsquare!
        
        // Only fire if gridSquare as not beed attacked yet
        if (selectedSquare.gridPoint?.attacked == false) {
            // Update the attacked property
            selectedSquare.gridPoint?.attacked = true
            
            // Update the square color based on occupied status
            if (selectedSquare.gridPoint?.occupied == true) {
                selectedSquare.backgroundColor = UIColor.greenColor()
            } else {
                selectedSquare.backgroundColor = UIColor.redColor()
            }
        } else  {
            // Get UIView's currentColor
            let currentColor = selectedSquare.backgroundColor
            
            // Flash yellow to show that they already fired here
            UIView.animateWithDuration(0.25, animations: {
                selectedSquare.backgroundColor = UIColor.yellowColor()
                }, completion: { finished in
                    UIView.animateWithDuration(0.25, animations: {
                        selectedSquare.backgroundColor = currentColor
                    })
            
                })
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
