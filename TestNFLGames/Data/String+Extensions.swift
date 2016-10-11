//
//  String+Extensions.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/2/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

extension String {
    func teamMascotToCity() -> String {
        
        switch self {
        case "cardinals":
            return "Arizona"
        case "falcons":
            return "Atlanta"
        case "ravens":
            return "Baltimore"
        case "bills":
            return "Buffalo"
        case "panthers":
            return "Carolina"
        case "bears":
            return "Chicago"
        case "bengals":
            return "Cincinatti"
        case "browns":
            return "Cleveland"
        case "cowboys":
            return "Dallas"
        case "broncos":
            return "Denver"
        case "lions":
            return "Detroit"
        case "packers":
            return "GreenBay"
        case "texans":
            return "Houston"
        case "colts":
            return "Indianapolis"
        case "jaguars":
            return "Jacksonville"
        case "chiefs":
            return "KansasCity"
        case "rams":
            return "LosAngeles"
        case "dolphins":
            return "Miami"
        case "vikings":
            return "Minnesota"
        case "patriots":
            return "NewEngland"
        case "saints":
            return "NewOrleans"
        case "giants":
            return "NewYorkGiants"
        case "jets":
            return "NewYorkJets"
        case "raiders":
            return "Oakland"
        case "eagles":
            return "Philadelphia"
        case "steelers":
            return "Pittsburg"
        case "chargers":
            return "SanDiego"
        case "49ers":
            return "SanFrancisco"
        case "seahawks":
            return "Seattle"
        case "buccaneers":
            return "TampaBay"
        case "titans":
            return "Tennessee"
        case "redskins":
            return "Washington"
        default:
            return ""
        }
    }
    
    func teamCityToMascot() -> String {
        
        switch self {
        case "Arizona":
            return "cardinals"
        case "Atlanta":
            return "falcons"
        case "Baltimore":
            return "ravens"
        case "Buffalo":
            return "bills"
        case "Carolina":
            return "panthers"
        case "Chicago":
            return "bears"
        case "Cincinatti":
            return "bengals"
        case "Cleveland":
            return "browns"
        case "Dallas":
            return "cowboys"
        case "Denver":
            return "broncos"
        case "Detroit":
            return "lions"
        case "GreenBay":
            return "packers"
        case "Houston":
            return "texans"
        case "Indianapolis":
            return "colts"
        case "Jacksonville":
            return "jaguars"
        case "KansasCity":
            return "chiefs"
        case "LosAngeles":
            return "rams"
        case "Miami":
            return "dolphins"
        case "Minnesota":
            return "vikings"
        case "NewEngland":
            return "patriots"
        case "NewOrleans":
            return "saints"
        case "NewYorkGiants":
            return "giants"
        case "NewYorkJets":
            return "jets"
        case "Oakland":
            return "raiders"
        case "Philadelphia":
            return "eagles"
        case "Pittsburg":
            return "steelers"
        case "SanDiego":
            return "chargers"
        case "SanFrancisco":
            return "49ers"
        case "Seattle":
            return "seahawks"
        case "TampaBay":
            return "buccaneers"
        case "Tennessee":
            return "titans"
        case "Washington":
            return "redskins"
        default:
            return ""
        }
    }
    
}
