//
//  Downloader.swift
//  RPAC
//
//  Created by Ty Schultz on 6/25/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import Kanna

struct Event {
    var time: String
    var location: String
    var activity: String
    var building: String

}

class Downloader: NSObject {
    var events : [[Event]]!
    var buildings : [String]!
    
    func downloadSchedule() -> ([[Event]]!,[String]!, Int) {
        
        var status = 0
        // Set the page URL we want to download
        let URL = NSURL(string: "http://www.nfl.com/liveupdate/scorestrip/ss.xml")
        
        // Try downloading it
        do {
            
            let htmlSource = try String(contentsOfURL: URL!, encoding: NSUTF8StringEncoding)
            
            if let doc = Kanna.HTML(html: htmlSource, encoding: NSUTF8StringEncoding) {
                
                let content = doc.css("g")
                for row in content {
                    let homeTeam = row.xpath("@hnn").first!
                    let awayTeam = row.xpath("@vnn").first!
                    //<g eid="2016082057" gsis="56859" d="Sat" t="9:00" q="P" h="LA" hnn="rams" hs="0" v="KC" vnn="chiefs" vs="0" rz="0" ga="" gt="PRE"/>
                    print ("Vote on the \(homeTeam.text!) vs the \(awayTeam.text!)")
                                  }
            }
        }catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
            status = error.code
        }

        return (events, buildings,status)
    }
 }
