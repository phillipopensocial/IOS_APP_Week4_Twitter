//
//  User.swift
//  Week3_Twitter
//
//  Created by Phillip Pang on 10/27/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class User: NSObject {

    
    var name:String?
    var screenName:String?
    var profileURL: URL?
    var tagLine: String?
    
    init(dictionary:NSDictionary){
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)
        }
        tagLine = dictionary["description"] as? String

    }
    
}
