//
//  GameViewController.swift
//  Battleship
//
//  Created by Elijah L Gavett on 3/6/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
//    var width: CGFloat!
//    var height: CGFloat = 9
//    var boxSize: CGFloat!
//    var gridStart: CGPoint!
    @IBOutlet weak var rotateButton: UIButton!
    weak var currentShip: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        
//        let sKView: SKView = SKView(frame: CGRectMake(10, 54, 100, 100))
//    
//        self.view.addSubview(sKView)
        
        // Touch Gesture
        let singleTap = UIGestureRecognizer(target: self, action: "selectShip:")
        singleTap.delegate = self
        
        let x = 10
        let y = 200
        for i in 1...5 {
            let ship = UIView()
            
            ship.frame = CGRectMake(CGFloat(x + i*20), CGFloat(y + i*20), 10.0, CGFloat(i*10))
            ship.backgroundColor = UIColor.redColor()
            
            ship.addGestureRecognizer(singleTap)
            
            self.view.addSubview(ship)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rotateCurrentShip(sender: AnyObject) {
        for subview in self.view.subviews {
            // Reverse every ships frame
            subview.frame = CGRectMake(subview.frame.origin.x, subview.frame.origin.y, subview.frame.height, subview.frame.width)
        }
    }
    
    func selectShip(sender: AnyObject?) {
        currentShip?.backgroundColor = UIColor.redColor()
        
        currentShip = (sender as! UIView)
        
        currentShip?.backgroundColor = UIColor.greenColor()
    }
    
    
//    func createGrid() {
//        let grid = SKNode() // Creates a node to hold
//        
//        let useableWidth = self.view.frame.width * 0.9
//        let usableHeight = self.view.frame.height * 0.8
//        
//        boxSize = usableHeight / height
//        width = CGFloat(Int(useableWidth / boxSize))
//        
//        let offsetX = (self.view.frame.width - boxSize * width) / 2
//        let offsetY = (self.view.frame.height - boxSize * height) / 2
//        
//        for col in 0..<Int(self.width){
//            for row in 0 ..< Int(self.height){
//                // BOX CREATION
//            }
//        }
//        
//        gridStart = CGPointMake(offsetX, offsetY)
//        grid.position = CGPointMake(offsetX, offsetY)
//        //addChild(grid)
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
