//
//  User.swift
//  Week3_Twitter
//
//  Created by Phillip Pang on 10/27/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class User: NSObject {

    static let Notification_UserDidLogin = Notification.Name("UserDidLogin")
    static let Notification_UserDidLogout = Notification.Name("UserDidLogout")
    
    var name:String?
    var screenName:String?
    var profileURL: URL?
    var profileBGURL: URL?
    var tagLine: String?
    var tweetsCount: NSNumber?
    var followingCount: NSNumber?
    var followersCount: NSNumber?
    
    
    var dictionary: NSDictionary?
    
    init(dictionary:NSDictionary){
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        tagLine = dictionary["description"] as? String
        tweetsCount = dictionary["statuses_count"] as? NSNumber
        followingCount = dictionary["friends_count"] as? NSNumber
        followersCount = dictionary["followers_count"] as? NSNumber
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString.replacingOccurrences(of: "_normal", with: "") )
        }
        
        let profileBGURLString = dictionary["profile_background_image_url_https"] as? String
        if let profileBGURLString = profileBGURLString {
            
            profileBGURL = URL(string: profileBGURLString.replacingOccurrences(of: "_normal", with: "") )
        }


    }
    
    
    static var _currentUser: User?
    
    //Computed properties
    class var currentUser: User? {
        get {
            
            if _currentUser == nil {
                
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    
                    let dictionary  = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
                
            return _currentUser
            
        }
        
        set(user){
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                    defaults.setValue(data, forKey: "currentUserData")
                
                //Save to Disk
                defaults.synchronize()
                
            }else{
                
                //Reset the data
                defaults.setValue(nil, forKey: "currentUserData")

            }

        }
    }
    
}
