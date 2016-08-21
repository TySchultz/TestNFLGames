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
    dynamic  var date: String      = ""
    dynamic  var homeScore: String = ""
    dynamic  var awayScore: String = ""
    dynamic var gameTime: String = ""

// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
