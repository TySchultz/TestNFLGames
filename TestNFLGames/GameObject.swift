//
//  Game.swift
//  TestNFLGames
//
//  Created by Nick Armold on 8/18/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import Foundation
import RealmSwift

// Dog model
class GameRealm: Object {
    var homeTeam = ""
    var awayTeam = ""
    var date = ""
    var homeScore = ""
    var awayScore = ""

}