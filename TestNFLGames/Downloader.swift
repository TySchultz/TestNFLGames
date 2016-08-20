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
    var games :[Game] = []
    
    let rootRef = FIRDatabase.database().reference()
    
    func downloadSchedule() -> ([Game]) {
        
        var status = 0
        // Set the page URL we want to download
        var count = 1
        
        while count < 16 {
            let URL = NSURL(string: "http://www.nfl.com/ajax/scorestrip?season=2016&seasonType=REG&week=\(count)")

            let itemsRef = rootRef.childByAppendingPath("NFL-games").child("Week \(count)")
   
            
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
                        newGame.date = row.xpath("@eid").first!.text!
                        newGame.homeScore = row.xpath("@hs").first!.text!
                        newGame.awayScore = row.xpath("@vs").first!.text!
                        
                        
                        let id = row.xpath("@gsis").first!.text!
                        
                        itemsRef.child(id).child("homeTeam").setValue(newGame.homeTeam)
                        itemsRef.child(id).child("awayTeam").setValue(newGame.awayTeam)
                        itemsRef.child(id).child("data").setValue(newGame.date)
                        itemsRef.child(id).child("homeScore").setValue(newGame.homeScore)
                        itemsRef.child(id).child("awayScore").setValue(newGame.awayScore)

                        // Get the default Realm
                        let realm = try! Realm()
                        // You only need to do this once (per thread)
                        
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
            count += 1
            
        }

        return (games)
    }
 }
