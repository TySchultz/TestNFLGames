//
//  TeamActivity.swift
//  TestNFLGames
//
//  Created by Ty Schultz on 10/1/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class TeamActivity: UIActivity {
    var pictureImage : UIImage?
    
    init(image: UIImage?){
        self.pictureImage = image
    }
    
    override var activityType: UIActivityType {
        return UIActivityType(rawValue: "activityType.Team")
    }
    
    override var activityTitle: String? {
        return "week"
    }
    
    override var activityImage: UIImage?{
        get {
            return self.pictureImage
        }
        set {
            self.pictureImage = newValue
        }
    }
    
    func setImage(image : UIImage) {
        self.activityImage = image
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
}
