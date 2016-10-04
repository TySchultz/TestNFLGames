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
import Parse

class Downloader: NSObject {
    
    let NFLURL = "http://www.nfl.com/ajax/scorestrip?season=2016&seasonType=REG&week="
    let TEAMSTATSURL = "http://www.fftoday.com/stats/16_run_pass_ratios.html"
    let CURRENTWEEKURL = "http://www.nfl.com/liveupdate/scorestrip/ss.xml"
    var games :Results<Game>?
    var realm : Realm?
    var week = 0
    
    
    //PUBLIC 
    
    func refreshSeasonData(){
        
        realm = try! Realm()
        
        //Season
        downloadSeason()
    }
    
    public func currentWeek() -> Int {
        return 4 
    }
    
    func refreshCurrentWeek(action : (() -> ())?){

        DispatchQueue(label: "background").async {
            autoreleasepool {
                let backgroundRealm = try! Realm()
                
                let URL = Foundation.URL(string: self.CURRENTWEEKURL)
                // Try downloading it
                do {
                    let htmlSource = try String(contentsOf: URL!, encoding: String.Encoding.utf8)
                    if let doc = Kanna.HTML(html: htmlSource, encoding: String.Encoding.utf8) {
                        let content = doc.css("g")
                        
                        let ee = doc.css("gms")
                        var serverWeek = 0
                        for row in ee {
                            serverWeek = Int(row.xpath("@w").first!.text!)!
                        }
                        
                        for row in content {
                            // Create a Game object
                            // Add to the Realm inside a transaction
                            try! backgroundRealm.write {
                                backgroundRealm.add(self.createNewGame(row: row, gameWeek: serverWeek), update: true)
                            }
                        }
                    }
                }catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }
                DispatchQueue.main.async {
                    action!()
                }
            }
        }

    }
    
    //PRIVATE
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
    
    private func downloadSeason() {
        for week in 1...16 {
            downloadWeek(week: week)
        }
    }
    
    private func createNewGame(row : XMLElement, gameWeek : Int ) -> Game{
        let newGame = Game()
        newGame.homeTeam = row.xpath("@hnn").first!.text!
        newGame.awayTeam = row.xpath("@vnn").first!.text!
        newGame.date = row.xpath("@eid").first!.text!
        newGame.homeScore = row.xpath("@hs").first!.text!
        newGame.awayScore = row.xpath("@vs").first!.text!
        newGame.gameStart = row.xpath("@t").first!.text!
        newGame.id = row.xpath("@gsis").first!.text!
        newGame.quarter = row.xpath("@q").first!.text!
        newGame.gameClock = row.xpath("@k").first?.text ?? ""
        newGame.gameWeek = gameWeek
        newGame.votes = List<Vote>()
        
//        let values = formatTimeAndDate(row.xpath("@t").first!.text!, date: row.xpath("@eid").first!.text!)
//        newGame.gameStart = values.time
//        newGame.date = values.date
//        
//        var gameScore = PFObject(className: "Game")
//        gameScore.setObject(newGame.homeTeam, forKey: "homeTeam")
//        gameScore.setObject(newGame.awayTeam, forKey: "awayTeam")
//        gameScore.setObject(newGame.date, forKey: "date")
//        gameScore.setObject(newGame.homeScore, forKey: "homeScore")
//        gameScore.setObject(newGame.awayScore, forKey: "awayScore")
//        gameScore.setObject(newGame.gameStart, forKey: "gameStart")
//        gameScore.setObject(newGame.id, forKey: "id")
//        gameScore.setObject(newGame.quarter, forKey: "quarter")
//        gameScore.setObject(newGame.gameClock, forKey: "gameClock")
//        gameScore.setObject(newGame.gameWeek, forKey: "gameWeek")
//
//        try! gameScore.save()
    
        return newGame
    }
 }


//MARK: Team Creation
extension Downloader {
    
    
    func downloadTeams() {
        
        realm = try! Realm()
        let URL = Foundation.URL(string: TEAMSTATSURL)
        
        // Try downloading it
        do {
            let htmlSource = try String(contentsOf: URL!, encoding: String.Encoding.utf8)
            if let doc = Kanna.HTML(html: htmlSource, encoding: String.Encoding.utf8) {
                let content = doc.css("tbody tr")

                for row in content {
                    let tableData = row.css("td")
                    let team = Team()
                    var count = 0
                    for td in tableData {
                        switch count {
                        case 0:
                            team.teamName = td.innerHTML!
                            break
                        case 1:
                            team.rushAttempts = tdNumber(tableData: td.innerHTML)
                            break
                        case 2:
                            team.rushAttemptsPerGame = tdNumber(tableData: td.innerHTML)
                            break
                        case 3:
                            team.passAttempts = tdNumber(tableData: td.innerHTML)
                            break
                        case 4:
                            team.passAttemptsPerGame = tdNumber(tableData: td.innerHTML)
                            break
                        case 6:
                            team.playsPerGame = tdNumber(tableData: td.innerHTML)
                            break
                        default:
                            break
                        }
                        count += 1
                    }

                    try! realm!.write {
                        realm!.add(team, update: true)
                    }
                    
                }
            }
        }catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    func tdNumber(tableData : String?) -> CGFloat {
        if let n = NumberFormatter().number(from: tableData!) {
            return CGFloat(n)
        }
        return 0.0
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
