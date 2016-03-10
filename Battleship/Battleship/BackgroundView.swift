//
//  BackgroundView.swift
//  Battleship
//
//  Created by Eli Gavett on 2016-03-08.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class BackgroundView: UIView, UIGestureRecognizerDelegate {
    
    var currentShip: ShipView?
    var panRecognizer: UIPanGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.currentShip = nil
        
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: ("moveShip:"))
        self.panRecognizer?.delegate = self
        self.panRecognizer?.cancelsTouchesInView = false
        self.addGestureRecognizer(panRecognizer!)
        
        self.backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.currentShip = nil
        
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: ("moveShip:"))
        self.panRecognizer?.delegate = self
        self.panRecognizer?.cancelsTouchesInView = false
        self.addGestureRecognizer(panRecognizer!)
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: Touch Handlers
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Get the location
        let t: UITouch = touches.first!
        let location: CGPoint = t.locationInView(self)
        
        self.currentShip?.backgroundColor = UIColor.redColor()
        
        self.currentShip = self.shipAt(location)
        self.currentShip?.backgroundColor = UIColor.greenColor()
        
    }
    
    func shipAt(point: CGPoint) -> ShipView? {
        //for ship in self.subviews as! Array<ShipView> {
        for ship in self.subviews {
            if ship.dynamicType == ShipView.self{
                if ship.pointInside(point, withEvent: nil){
                    return (ship as! ShipView)
                }
            }
        }
        return nil
    }
    
    func moveShip(gr: UIPanGestureRecognizer) {
        if (gr.state == UIGestureRecognizerState.Changed){
            if self.currentShip != nil {
                let translation = gr.translationInView(self)
                var newLocation = self.currentShip!.frame.origin
            
                newLocation.x += translation.x
                newLocation.y += translation.y
                
                self.currentShip!.frame = CGRectMake(newLocation.x, newLocation.y, self.currentShip!.frame.width, self.currentShip!.frame.height)
            
                self.setNeedsDisplay()
                gr.setTranslation(CGPointZero, inView: self)
            }
        }
    }
}
