//
//  GameViewController.swift
//  Battleship
//
//  Created by Elijah L Gavett on 3/6/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit
//import SpriteKit

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
//    var width: CGFloat!
//    var height: CGFloat = 9
//    var boxSize: CGFloat!
//    var gridStart: CGPoint!
    @IBOutlet weak var rotateButton: UIButton!
    weak var currentShip: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view = BackgroundView(frame: self.view.frame)
        
        let x = 50
        let y = 450
        for i in 1...5 {
            let ship = ShipView()
            
            let singleTap = UITapGestureRecognizer(target: self, action: "selectShip:")
            singleTap.delegate = self
            ship.addGestureRecognizer(singleTap)
            ship.tag = i
            
            if(i == 1) {
                ship.frame = CGRectMake(CGFloat(x) + CGFloat(i)*(self.view.frame.width/10.0+10.0), CGFloat(y), (self.view.frame.width/10.0), CGFloat(CGFloat(3)*(self.view.frame.width/10.0)))
            } else {
                ship.frame = CGRectMake(CGFloat(x) + CGFloat(i)*(self.view.frame.width/10.0+10.0), CGFloat(y), (self.view.frame.width/10.0), CGFloat(CGFloat(i)*(self.view.frame.width/10.0)))
            }
            
            ship.backgroundColor = UIColor.redColor()
            
            ship.layer.borderColor = UIColor.blackColor().CGColor
            ship.layer.borderWidth = 1.0
            
            
            
            self.view.addSubview(ship)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rotateCurrentShip(sender: AnyObject) {
        currentShip = (self.view as! BackgroundView).currentShip
        currentShip?.frame = CGRectMake(currentShip!.frame.origin.x, currentShip!.frame.origin.y, currentShip!.frame.height, currentShip!.frame.width)
    }
    
    func selectShip(sender: UIGestureRecognizer) {
        currentShip?.backgroundColor = UIColor.redColor()
        
        currentShip = sender.view
        
        currentShip?.backgroundColor = UIColor.greenColor()
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
