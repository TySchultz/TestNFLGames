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
            let URL = Foundation.URL(string: "http://www.nfl.com/ajax/scorestrip?season=2016&seasonType=REG&week=\(count)")

            let itemsRef = rootRef.child(byAppendingPath: "NFL-games").child("\(1)")
   
            // Try downloading it
            do {
                
                let htmlSource = try String(contentsOf: URL!, encoding: String.Encoding.utf8)
                
                if let doc = Kanna.HTML(html: htmlSource, encoding: String.Encoding.utf8) {
                    
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
        
        ref.observe(FIRDataEventType.value, with: { (snapshot) in
            
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
    
    func formatTimeAndDate(_ time:String, date:String) -> (time: String, date: String)
    {
        var dateNew = date
        //Trying to get date at format of example -> "2016-09-11"
        dateNew.insert("-", at: dateNew.characters.index(dateNew.startIndex, offsetBy: 4))
        dateNew.insert("-", at: dateNew.characters.index(dateNew.startIndex, offsetBy: 7))
        dateNew.remove(at: dateNew.characters.index(dateNew.startIndex, offsetBy: 11))
        dateNew.remove(at: dateNew.characters.index(dateNew.startIndex, offsetBy: 10))
        
        //Gets date and time in format below
        let dateAndTime = dateNew + (" " + time)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd h:mm"
        let kickoffTime = formatter.date(from: dateAndTime)
        
        
        
        //Adjust AM/PM for London games that start at 9:15 AM
        let kickoffTimeFormat = DateFormatter()
        kickoffTimeFormat.dateFormat = "h:mm"
        let kickOff = kickoffTimeFormat.date(from: time)
        
                let londonFormatter = DateFormatter()
                londonFormatter.dateFormat = "h:mm"
                let londonTime = londonFormatter.date(from: "9:15")
        
                let londonCompare = (kickOff?.compare(londonTime!) == ComparisonResult.orderedSame)
                print(londonCompare)
        
        
        //Reformat time to be more readable
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "h:mm"
        var timeString = formatterTime.string(from: kickOff!)
        
                //If London game then we add AM b/c they are only AM games
                if (londonCompare == false)
                {
                    timeString = timeString + " PM"
                }
                else {
                    timeString = timeString + " AM"
                }
        
        
        //Reformat date to be more readable
        let formatterTwo = DateFormatter()
        formatterTwo.dateFormat = "E, MMM d"
        let dateString = formatterTwo.string(from: kickoffTime!)
        
 
        return (timeString, dateString)
        
    }
 }
