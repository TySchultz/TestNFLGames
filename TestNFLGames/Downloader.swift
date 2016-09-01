//
//  Downloader.swift
//  RPAC
//
//  Created by Ty Schultz on 6/25/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import Kanna
import RealmSwift
import Firebase


class Downloader: NSObject {
    var games :Results<Game>?
    
    let rootRef = FIRDatabase.database().reference()
    
    func downloadSchedule() -> (Results<Game>) {
        
        var status = 0
        // Set the page URL we want to download
        var count = 1
        let realm = try! Realm()

//        while count < 16 {
            let URL = NSURL(string: "http://www.nfl.com/ajax/scorestrip?season=2016&seasonType=REG&week=\(count)")

            let itemsRef = rootRef.childByAppendingPath("NFL-games").child("\(1)")
   
            // Try downloading it
            do {
                
                let htmlSource = try String(contentsOfURL: URL!, encoding: NSUTF8StringEncoding)
                
                if let doc = Kanna.HTML(html: htmlSource, encoding: NSUTF8StringEncoding) {
                    
                    let content = doc.css("g")
                    for row in content {
                        
                        // Create a Game object
                        
                        let newGame = Game()
                        newGame.homeTeam = row.xpath("@hnn").first!.text!
                        newGame.awayTeam = row.xpath("@vnn").first!.text!
                       // newGame.date = row.xpath("@eid").first!.text!
                        newGame.homeScore = row.xpath("@hs").first!.text!
                        newGame.awayScore = row.xpath("@vs").first!.text!
                       // newGame.gameTime = row.xpath("@t").first!.text!
                        
                        let values = formatTimeAndDate(row.xpath("@t").first!.text!, date: row.xpath("@eid").first!.text!)
                        newGame.gameTime = values.time
                        newGame.date = values.date
                        print("GAME TIME" + newGame.date)
                        
                        
                        let id = row.xpath("@gsis").first!.text!
                        
                        itemsRef.child(id).child("homeTeam").setValue(newGame.homeTeam)
                        itemsRef.child(id).child("awayTeam").setValue(newGame.awayTeam)
                        itemsRef.child(id).child("data").setValue(newGame.date)
                        itemsRef.child(id).child("homeScore").setValue(newGame.homeScore)
                        itemsRef.child(id).child("awayScore").setValue(newGame.awayScore)

                        
                        // Add to the Realm inside a transaction
                        try! realm.write {
                            realm.add(newGame)
                        }
                    }
                }
            }catch let error as NSError {
                print("Ooops! Something went wrong: \(error)")
                status = error.code
            }
//            count += 1
//        }
        games = realm.objects(Game)

        return (games!)
    }
    
    
    func ee() -> (Results<Game>) {
        
        let ref = rootRef.child("NFL-games").child("1")
        let realm = try! Realm()

//        
//        firebase.observeEventType(.Value, withBlock: { snapshot in
//            var tempItems = [NSDictionary]()
//            
//            for item in snapshot.children {
//                let child = item as! FDataSnapshot
//                let dict = child.value as! NSDictionary
//                tempItems.append(dict)
//            }
//            
//            self.items = tempItems
//            self.tableView.reloadData()
//            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//        })
        
        ref.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            
            let postDict = snapshot.value as! [String : AnyObject]
            
            var tempItems = [NSDictionary]()
            
            for item in snapshot.children {
                let child = item as! FIRDataSnapshot
                let dict = child.value as! NSDictionary
                tempItems.append(dict)
            }
            
           
            // ...
        })
        return realm.objects(Game)
    }
    
    func formatTimeAndDate(time:String, date:String) -> (time: String, date: String)
    {
        var dateNew = date
        //Trying to get date at format of example -> "2016-09-11"
        dateNew.insert("-", atIndex: dateNew.startIndex.advancedBy(4))
        dateNew.insert("-", atIndex: dateNew.startIndex.advancedBy(7))
        dateNew.removeAtIndex(dateNew.startIndex.advancedBy(11))
        dateNew.removeAtIndex(dateNew.startIndex.advancedBy(10))
        
        //Gets date and time in format below
        let dateAndTime = dateNew.stringByAppendingString(" " + time)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd h:mm"
        let kickoffTime = formatter.dateFromString(dateAndTime)
        
        
        
        //Adjust AM/PM for London games that start at 9:15 AM
        let kickoffTimeFormat = NSDateFormatter()
        kickoffTimeFormat.dateFormat = "h:mm"
        let kickOff = kickoffTimeFormat.dateFromString(time)
        
                let londonFormatter = NSDateFormatter()
                londonFormatter.dateFormat = "h:mm"
                let londonTime = londonFormatter.dateFromString("9:15")
        
                let londonCompare = (kickOff?.compare(londonTime!) == NSComparisonResult.OrderedSame)
                print(londonCompare)
        
        
        //Reformat time to be more readable
        let formatterTime = NSDateFormatter()
        formatterTime.dateFormat = "h:mm"
        var timeString = formatterTime.stringFromDate(kickOff!)
        
                //If London game then we add AM b/c they are only AM games
                if (londonCompare == false)
                {
                    timeString = timeString + " PM"
                }
                else {
                    timeString = timeString + " AM"
                }
        
        
        //Reformat date to be more readable
        let formatterTwo = NSDateFormatter()
        formatterTwo.dateFormat = "E, MMM d"
        let dateString = formatterTwo.stringFromDate(kickoffTime!)
        
 
        return (timeString, dateString)
        
    }
 }
