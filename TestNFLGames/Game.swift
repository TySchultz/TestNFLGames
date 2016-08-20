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
    var homeTeam: String = ""
    var awayTeam: String = ""
    var date: String = ""
    var homeScore: String = ""
    var awayScore: String = ""
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
