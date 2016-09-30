//
//  Vote.swift
//  TestNFLGames
//
//  Created by Tyler J Schultz on 9/30/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import RealmSwift

class Vote: Object {
    
    dynamic var side: Int = 0
    dynamic var game: Game? = nil
    dynamic var homeTeam: String = ""
    dynamic var awayTeam: String = ""
    dynamic var id: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func attachGame(game : Game){
        self.game = game
        self.homeTeam = game.homeTeam
        self.awayTeam = game.awayTeam
    }
}
