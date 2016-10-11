//
//  Team.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/1/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import Foundation
import RealmSwift

class Team: Object {
    
    dynamic var teamName: String   = ""
    dynamic var wins : Int = 0
    dynamic var losses : Int = 0
    dynamic var rushAttempts: CGFloat = 0
    dynamic var passAttempts: CGFloat = 0
    dynamic var rushAttemptsPerGame : CGFloat = 0
    dynamic var passAttemptsPerGame : CGFloat = 0
    dynamic var playsPerGame : CGFloat = 0
    
    override static func primaryKey() -> String? {
        return "teamName"
    }
}
