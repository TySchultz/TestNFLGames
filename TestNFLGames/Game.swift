//
//  Game.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/19/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import Foundation
import RealmSwift

class Game: Object {
    dynamic var homeTeam: String   = ""
    dynamic var awayTeam: String   = ""
    dynamic var date: String      = ""
    dynamic var homeScore: String = ""
    dynamic var awayScore: String = ""
    dynamic var gameClock: String = ""
    dynamic var gameStart: String = ""
    dynamic var quarter: String = ""
    dynamic var id: String = ""
    dynamic var gameWeek: Int = 0
    dynamic var thursdayGame : Bool = false
    var votes : List<Vote>?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}



