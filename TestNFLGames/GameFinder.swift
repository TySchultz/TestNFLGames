//
//  GameFinder.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/2/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import RealmSwift
class GameFinder: NSObject {
    
    var realm :Realm!
    
    var downloader : Downloader!
    override init(){
        realm = try! Realm()
        downloader = Downloader()

    }
    
    func downloadSeason() {
        //downloader.downloadSchedule()
    }
    
    func gamesForWeek(week: Int) -> [Any] {
        let queryResults = realm.objects(Game.self).filter("gameWeek = \(week)").sorted(byProperty: "date", ascending: false)
        return sortGamesInWeek(gameResults: queryResults)
    }

    func sortGamesInWeek(gameResults: Results<Game>) -> [Any] {
        var gamesWithSections : [Any] = []
        for game in gameResults {
            if game.thursdayGame {
                gamesWithSections.append(SectionHeader(title: game.date))
            }
            gamesWithSections.append(game)
        }
        return gamesWithSections
    }
    
    //Would organize team data if needed later on
//    func datesForTeam() {
//        var filteredGames : [[Game]] = []
//        filteredGames.append([])
//        for game in gameResults! {
//            filteredGames[0].append(game)
//        }
//        filteredGames[0].sort(by: { (FirstGame, SecondGame) -> Bool in
//            return FirstGame.gameWeek > SecondGame.gameWeek
//        })
//        currentGames = filteredGames
//    }
}
