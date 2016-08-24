//
//  League.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 8/23/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import Foundation
import RealmSwift

class League: Object {
    
    dynamic var leagueName : String = ""
    dynamic var points: Int         = 0
    dynamic var wins: Int           = 0
    dynamic var losses: Int         = 0

    override static func indexedProperties() -> [String] {
        return ["leagueName"]
    }
    
}
