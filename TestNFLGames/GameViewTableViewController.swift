//
//  GameViewTableViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/20/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class GameViewTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 2
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! GameViewMainCell
            
            // Configure the cell...
            
            
            
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) as! PlayerCell
            
            // Configure the cell...
            
            cell.homePlayers.addArrangedSubview(createView("Ty"))
            cell.homePlayers.addArrangedSubview(createView("Zelda"))
            cell.homePlayers.addArrangedSubview(createView("Sam"))
            cell.homePlayers.addArrangedSubview(createView("Jim"))
            cell.homePlayers.addArrangedSubview(createView("Ty"))
            
            cell.awayPlayers.addArrangedSubview(createView("Nick"))
            cell.awayPlayers.addArrangedSubview(createView("Katie"))
            cell.awayPlayers.addArrangedSubview(createView("JT"))
            cell.awayPlayers.addArrangedSubview(createView("Billy"))
            cell.awayPlayers.addArrangedSubview(createView("Matt"))
            cell.awayPlayers.addArrangedSubview(createView("Jeff"))
            cell.awayPlayers.addArrangedSubview(createView("Johnny"))



            return cell
            
        }
    }
 

    func createView (name : String) -> UILabel {
        let lab = UILabel()
        lab.text = name
        lab.font = UIFont(name: "System", size: 16.0)
        return lab
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
