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

struct Game {
    var homeTeam: String
    var awayTeam: String
    var date: String
    var homeScore: String
    var awayScore: String
}

class Downloader: NSObject {
    var games :[Game] = []
    
    var rootRef = FIRDatabase.database().reference()
    let itemsRef = rootRef.childByAppendingPath("NFL-games")
    
    func downloadSchedule() -> ([Game]) {
        
        var status = 0
        // Set the page URL we want to download
        let URL = NSURL(string: "http://www.nfl.com/liveupdate/scorestrip/ss.xml")
        
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
                    
                    // Get the default Realm
                    let realm = try! Realm()
                    // You only need to do this once (per thread)
                    
                    // Add to the Realm inside a transaction
                    try! realm.write {
                        realm.add(newGame)
                    }
                    
                    let ev = Game(homeTeam: row.xpath("@hnn").first!.text!,
                                   awayTeam: row.xpath("@vnn").first!.text!,
                                   date: row.xpath("@eid").first!.text!,
                                   homeScore: row.xpath("@hs").first!.text!,
                                   awayScore: row.xpath("@vs").first!.text!)
                    
                    games.append(ev)
                    //<g eid="2016082057" gsis="56859" d="Sat" t="9:00" q="P" h="LA" hnn="rams" hs="0" v="KC" vnn="chiefs" vs="0" rz="0" ga="" gt="PRE"/>
                    print ("Vote on the \(ev)")
                                  }
            }
        }catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
            status = error.code
        }

        return (games)
    }
 }
