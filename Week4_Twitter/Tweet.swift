//
//  Tweet.swift
//  Week3_Twitter
//
//  Created by Phillip Pang on 10/27/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var id: NSNumber? = 0
    var favorited: String?
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileUserDictionary : NSDictionary?
    var profileUserName: String?
    var profileImageUrlHttps: URL?

    
    init(dictionary: NSDictionary){
        
        id = dictionary["id"] as? NSNumber
        favorited = dictionary["favorited"] as?String
        text = dictionary["text"] as? String
        retweetCount = ( dictionary["reweet_count"] as? Int ) ?? 0
        favoritesCount = ( dictionary["favourites_count"] as? Int ) ?? 0
        
        profileUserDictionary = ( dictionary["user"] as? NSDictionary) ?? [:]
        profileUserName = ( profileUserDictionary?["name"] as? String) ?? "n/a"
        profileImageUrlHttps = URL(string: ( profileUserDictionary?["profile_image_url_https"] as? String)! )
        
        
        
        let timestampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        if let timestampString = timestampString {
            timestamp = formatter.date(from: timestampString)
        }
    }
    
    class func tweetFromArray( dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
            
        }
    
        return tweets
    }
}
