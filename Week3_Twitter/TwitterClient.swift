//
//  TwitterClient.swift
//  Week3_Twitter
//
//  Created by Phillip Pang on 10/28/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "KvwIhQcx88dGBZmzETQTNH57C", consumerSecret: "tSwf38Re0RvX1W2CKFsYJv3uiRbpMQlPWyDXNWY2WGy10pNfnA")
    
    func currentAccount( success: @escaping (User) ->(), failure: @escaping (Error) ->() ) {
        
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response:Any!) in
            
                let userDictionary = response as! NSDictionary
                //print(user)
            
                let user = User(dictionary: userDictionary)
            
                success(user)

            
            }, failure: { (task:URLSessionDataTask?, errors:Error) in
                
                failure(errors)
        })
    }
    
    func homeTimeLine( success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> () ) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
                let dictionaries = response as! [NSDictionary]
                
                let tweets = Tweet.tweetFromArray(dictionaries: dictionaries)
                
                success(tweets)
            
            
            }, failure: { (task: URLSessionDataTask?, errors: Error) in
               
                failure(errors)
        })

    }
    
}
