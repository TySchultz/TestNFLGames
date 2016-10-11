//
//  UserViewController.swift
//  TestNFLGames
//
//  Created by Nick Armold on 10/10/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import Foundation
import UIKit
import Parse

class UserViewController: UIViewController {
    
    @IBOutlet weak var currentUserLabel: UILabel!
    @IBOutlet weak var dateJoinedUser: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var userRecordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let user = PFUser.current()
        
        print("USER EMAIL " + (user?.username)!)
        
        
        self.currentUserLabel.text = user?.username
        
        let userDate = user?.createdAt
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        let joinedDate = formatter.string(from: userDate!)

        
        self.dateJoinedUser.text = joinedDate
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


