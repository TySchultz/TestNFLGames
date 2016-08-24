//
//  User.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/23/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    dynamic var id : String     = ""
    dynamic var name: String    = ""
    dynamic var votes: String   = ""
    var leagues: List<League> = List<League>()

    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}
