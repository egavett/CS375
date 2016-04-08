//
//  FriendsListTableViewController.swift
//  Battleship
//
//  Created by Elijah L Gavett on 2/28/16.
//  Copyright © 2016 Elijah L Gavett. All rights reserved.
//

import UIKit

class FriendsListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "FriendsListTableViewCell", bundle: nil), forCellReuseIdentifier: "friendCell")
        
        self.navigationController?.toolbarHidden = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //let toolbar = UIToolbar()
        //toolbar.sizeToFit()
        
        
        //toolbar.setItems([item1, item2, item3], animated: true)
        
       // toolbar.backgroundColor = UIColor.redColor()
        //self.view.addSubview(toolbar)
       // self.navigationController?.toolbar.setItems([item1, item2, item3], animated: true)
        
        
       // toolbar.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        //toolbar.autoPinEdge(.Right, toEdge: .Right, ofView: self.view)
        //toolbar.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self.view)
        
       // toolbar.autoSetDimension(.Height, toSize: 44.0)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.toolbarHidden = true
    }
    
    //override func toolbarItems() ->[UIBarButtonItem]? {
    override var toolbarItems: [UIBarButtonItem]? {
        get{
            let item1 = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: Selector("addFriend"))
            let item2 = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            let item3 = UIBarButtonItem(title: "Remove", style: .Plain, target: self, action: Selector("removeFriend"))
            
            return [item1, item2, item3]
        }
        
        set{
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    func addFriend(sender: AnyObject) {
        print("You added a new friend!")
        // TODO - push controller to add friend
    }
    
    func removeFriend(sender: AnyObject) {
        print("You just lost a friend...")
        // TODO - edit table to remove a friend
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FriendsListTableViewCell?
        
        cell = (tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as! FriendsListTableViewCell)
        
        cell?.friendLabel.text = "Friend Name"
        
        cell?.challengeButton.addTarget(self, action: #selector(FriendsListTableViewController.sendChallenge(_:)), forControlEvents: .TouchUpInside)
        return cell!
    }

    func sendChallenge(sender: AnyObject?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameVC = storyboard.instantiateViewControllerWithIdentifier("GameViewController")
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
