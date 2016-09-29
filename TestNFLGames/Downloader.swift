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


class Downloader: NSObject {
    
    let NFLURL = "http://www.nfl.com/ajax/scorestrip?season=2016&seasonType=REG&week="
    
    var games :Results<Game>?
    var realm : Realm?
    var week = 0
    
    func downloadSchedule() -> (Results<Game>) {
        
        realm = try! Realm()

        //Season 
        downloadSeason()
        
        //Week
        //week = 1
        //downloadWeek(week)
        
        games = realm!.objects(Game.self)

        return (games!)
    }
    
    func createNewGame(row : XMLElement, gameWeek : Int ) -> Game{
        let newGame = Game()
        newGame.homeTeam = row.xpath("@hnn").first!.text!
        newGame.awayTeam = row.xpath("@vnn").first!.text!
        newGame.date = row.xpath("@eid").first!.text!
        newGame.homeScore = row.xpath("@hs").first!.text!
        newGame.awayScore = row.xpath("@vs").first!.text!
        newGame.gameTime = row.xpath("@t").first!.text!
        newGame.id = row.xpath("@gsis").first!.text!
        newGame.gameWeek = gameWeek

        let values = formatTimeAndDate(row.xpath("@t").first!.text!, date: row.xpath("@eid").first!.text!)
        newGame.gameTime = values.time
        newGame.date = values.date
        
        return newGame
    }
    
    private func downloadSeason() {
        for week in 1...16 {
            downloadWeek(week: week)
        }
    }
    
    private func downloadWeek(week : Int) {
        let URL = Foundation.URL(string: NFLURL + String(week))
        print(week)
        // Try downloading it
        do {
            let htmlSource = try String(contentsOf: URL!, encoding: String.Encoding.utf8)
            if let doc = Kanna.HTML(html: htmlSource, encoding: String.Encoding.utf8) {
                let content = doc.css("g")
                for row in content {
                    // Create a Game object
                    // Add to the Realm inside a transaction
                    try! realm!.write {
                        realm!.add(createNewGame(row: row, gameWeek: week), update: true)
                    }
                }
            }
        }catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
 }


extension Downloader {
    
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
