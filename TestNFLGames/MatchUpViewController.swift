//
//  MatchUpViewController.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/4/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class MatchUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Show the top bar
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isOpaque = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
