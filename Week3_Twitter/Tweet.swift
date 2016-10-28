//
//  Tweet.swift
//  Week3_Twitter
//
//  Created by Phillip Pang on 10/27/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = ( dictionary["reweet_count"] as? Int ) ?? 0
        favoritesCount = ( dictionary["favourites_count"] as? Int ) ?? 0
        
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
