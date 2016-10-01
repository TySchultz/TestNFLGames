//
//  shareController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/1/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import ASHorizontalScrollView
class shareController: UIViewController {
    var dismissModal : ((_ filter: String, _ teamName : String, _ week : Int ) -> ())?

    @IBOutlet weak var activityView: TNGView!
    var scrollViewWeeks: ASHorizontalScrollView!
    var scrollViewTeams: ASHorizontalScrollView!
    
    var filter = ""
    var teamName = ""
    var currentWeek = 0

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        closeButton.layer.cornerRadius = 8.0
       
        createTeamScroll()
        createWeekScroll()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismissModal?(filter, teamName, currentWeek)
    }


    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func teamSelected(sender : UIButton){
        let name = teamNameForIndex(team: sender.tag)
        self.teamName = name.teamCityToMascot()
        filter = "homeTeam = '" + self.teamName + "' OR awayTeam = '" + self.teamName + "'"
        self.dismiss(animated: true, completion: nil)
    }
    
    func weekSelected(sender : UIButton){
        let week = sender.tag
        self.currentWeek = week
        filter = "gameWeek = \(week)"
        self.dismiss(animated: true, completion: nil)
    }
    
    func createTeamScroll() {
        scrollViewTeams = ASHorizontalScrollView(frame:CGRect(x: 8, y: 24, width: self.view.frame.width-16, height: 100))
        scrollViewTeams.leftMarginPx = 10
        scrollViewTeams.miniMarginPxBetweenItems = 15
        scrollViewTeams.miniAppearPxOfLastItem = 15
        scrollViewTeams.uniformItemSize = CGSize(width: 64, height: 64)
        //This must be called after changing any size or margin property of this class to get acurrate margin
        scrollViewTeams.setItemsMarginOnce()
        for index in 0...31{
            let team = UIButton(frame: CGRect.zero)
            team.layer.cornerRadius = 8.0
            team.layer.masksToBounds = true
            team.tag = index
            team.setBackgroundImage(UIImage(named: teamNameForIndex(team: index)), for: UIControlState.normal)
            team.addTarget(self, action: #selector(self.teamSelected(sender:)), for: UIControlEvents.touchUpInside)
            scrollViewTeams.addItem(team)
        }
        self.activityView.addSubview(scrollViewTeams)
    }
    
    func createWeekScroll() {
        scrollViewWeeks = ASHorizontalScrollView(frame:CGRect(x: 8, y: 148, width: self.view.frame.width-16, height: 100))
        scrollViewWeeks.leftMarginPx = 10
        
        scrollViewWeeks.miniMarginPxBetweenItems = 8
        scrollViewWeeks.miniAppearPxOfLastItem = 15
        scrollViewWeeks.uniformItemSize = CGSize(width: 64, height: 64)
        //This must be called after changing any size or margin property of this class to get acurrate margin
        scrollViewWeeks.setItemsMarginOnce()
        for index in 1...16{
            let week = UIButton(frame: CGRect.zero)
            week.layer.cornerRadius = 8.0
            week.layer.masksToBounds = true
            week.layer.borderColor = UIColor.black.cgColor
            week.layer.borderWidth = 1.0
            week.tag = index
            week.setTitle(String(index), for: UIControlState.normal)
            week.setTitleColor(UIColor.black, for: UIControlState.normal)
            week.addTarget(self, action: #selector(self.weekSelected(sender:)), for: UIControlEvents.touchUpInside)
            scrollViewWeeks.addItem(week)
        }
        self.activityView.addSubview(scrollViewWeeks)
    }

}

extension shareController {
    func teamNameForIndex(team : Int ) -> String {
        
        switch team {
        case 0:
            return "Arizona"
        case 1:
            return "Atlanta"
        case 2:
            return "Baltimore"
        case 3:
            return "Buffalo"
        case 4:
            return "Carolina"
        case 5:
            return "Chicago"
        case 6:
            return "Cincinatti"
        case 7:
            return "Cleveland"
        case 8:
            return "Dallas"
        case 9:
            return "Denver"
        case 10:
            return "Detroit"
        case 11:
            return "GreenBay"
        case 12:
            return "Houston"
        case 13:
            return "Indianapolis"
        case 14:
            return "Jacksonville"
        case 15:
            return "KansasCity"
        case 16:
            return "LosAngeles"
        case 17:
            return "Miami"
        case 18:
            return "Minnesota"
        case 19:
            return "NewEngland"
        case 20:
            return "NewOrleans"
        case 21:
            return "NewYorkGiants"
        case 22:
            return "NewYorkJets"
        case 23:
            return "Oakland"
        case 24:
            return "Philadelphia"
        case 25:
            return "Pittsburg"
        case 26:
            return "SanDiego"
        case 27:
            return "SanFrancisco"
        case 28:
            return "Seattle"
        case 29:
            return "TampaBay"
        case 30:
            return "Tennessee"
        case 31:
            return "Washington"
        default:
            return ""
        }
    }

}
