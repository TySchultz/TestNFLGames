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
    
    dynamic var id : String            = ""
    dynamic var homeTeam: String       = ""
    dynamic var awayTeam: String       = ""
    dynamic var startDate: String      = ""
    dynamic var currentTime: String    = ""
    dynamic var currentPeriod: String  = ""
    dynamic var homeScore: String         = ""
    dynamic var awayScore: String         = ""
    var homeVotes : List<Vote> = List<Vote>()
    var awayVotes : List<Vote> = List<Vote>()
    dynamic var homeVoteCount :Int     = 0
    dynamic var awayVoteCount :Int     = 0
    dynamic var totalPotCount :Int     = 0

    override static func indexedProperties() -> [String] {
        return ["id"]
    }

}
