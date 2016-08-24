//
//  Vote.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/23/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import Foundation
import RealmSwift

class Vote: Object {
    

    
    dynamic var gameID : String = ""
    dynamic var voteSide: Int   = 0
    
    override static func indexedProperties() -> [String] {
        return ["gameID"]
    }
}
