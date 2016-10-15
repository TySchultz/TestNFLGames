//
//  Constants.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/15/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

struct Constants {
    
    static let pageHeaderFont = UIFont.boldSystemFont(ofSize: 32)

    static let sectionHeaderFont = UIFont.boldSystemFont(ofSize: 22)

    
    static let mainInfoBold = UIFont.boldSystemFont(ofSize: 16)
    static let mainInfoNormal = UIFont.systemFont(ofSize: 16)
    
    static let subInfoBold = UIFont.boldSystemFont(ofSize: 13)
    static let subInfoNormal = UIFont.systemFont(ofSize: 13)
    
    static func teamColorForCityName(name : String) -> UIColor {
        switch name {
        case "Arizona":
            return UIColor(red:0.77, green:0.15, blue:0.24, alpha:1.00)
        case "Atlanta":
            return UIColor(red:0.77, green:0.15, blue:0.24, alpha:1.00)
        case "Baltimore":
            return UIColor(red:0.14, green:0.08, blue:0.39, alpha:1.00)
        case "Buffalo":
            return UIColor(red:0.77, green:0.13, blue:0.18, alpha:1.00)
        case "Carolina":
            return UIColor(red:0.00, green:0.52, blue:0.77, alpha:1.00)
        case "Chicago":
            return UIColor(red:0.11, green:0.11, blue:0.24, alpha:1.00)
        case "Cincinatti":
            return UIColor(red:0.96, green:0.31, blue:0.14, alpha:1.00)
        case "Cleveland":
            return UIColor(red:0.93, green:0.34, blue:0.13, alpha:1.00)
        case "Dallas":
            return UIColor(red:0.68, green:0.66, blue:0.69, alpha:1.00)
        case "Denver":
            return UIColor(red:0.04, green:0.13, blue:0.24, alpha:1.00)
        case "Detroit":
            return UIColor(red:0.02, green:0.43, blue:0.71, alpha:1.00)
        case "GreenBay":
            return UIColor(red:0.29, green:0.44, blue:0.15, alpha:1.00)
        case "Houston":
            return UIColor(red:0.00, green:0.07, blue:0.24, alpha:1.00)
        case "Indianapolis":
            return UIColor(red:0.08, green:0.24, blue:0.51, alpha:1.00)
        case "Jacksonville":
            return UIColor(red:0.01, green:0.51, blue:0.60, alpha:1.00)
        case "KansasCity":
            return UIColor(red:0.93, green:0.16, blue:0.11, alpha:1.00)
        case "LosAngeles":
            return UIColor(red:0.05, green:0.13, blue:0.30, alpha:1.00)
        case "Miami":
            return UIColor(red:0.00, green:0.75, blue:0.81, alpha:1.00)
        case "Minnesota":
            return UIColor(red:1.00, green:0.78, blue:0.18, alpha:1.00)
        case "NewEngland":
            return UIColor(red:0.75, green:0.12, blue:0.11, alpha:1.00)
        case "NewOrleans":
            return UIColor(red:0.76, green:0.65, blue:0.27, alpha:1.00)
        case "NewYorkGiants":
            return UIColor(red:0.01, green:0.23, blue:0.49, alpha:1.00)
        case "NewYorkJets":
            return UIColor(red:0.01, green:0.42, blue:0.22, alpha:1.00)
        case "Oakland":
            return UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.00)
        case "Philadelphia":
            return UIColor(red:0.02, green:0.30, blue:0.33, alpha:1.00)
        case "Pittsburg":
            return UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.00)
        case "SanDiego":
            return UIColor(red:0.17, green:0.48, blue:0.77, alpha:1.00)
        case "SanFrancisco":
            return UIColor(red:0.77, green:0.01, blue:0.11, alpha:1.00)
        case "Seattle":
            return UIColor(red:0.05, green:0.13, blue:0.24, alpha:1.00)
        case "TampaBay":
            return UIColor(red:0.55, green:0.49, blue:0.42, alpha:1.00)
        case "Tennessee":
            return UIColor(red:0.24, green:0.24, blue:0.24, alpha:1.00)
        case "Washington":
            return UIColor(red:0.33, green:0.12, blue:0.16, alpha:1.00)
        default:
            return UIColor.white
        }
    }

}

