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

    //Singleton
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
    
    var loginSuccess: ( ()->() )?
    var loginFailure: ( (Error)->() )?
    
    func login(success: @escaping ()->(), failure: @escaping (Error)->() ) {
        
        //Store the closures
        loginSuccess = success
        loginFailure = failure
        
        //Get Oauth Token
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "KvwIhQcx88dGBZmzETQTNH57C", consumerSecret: "tSwf38Re0RvX1W2CKFsYJv3uiRbpMQlPWyDXNWY2WGy10pNfnA")
        
        //Reset (necessary to avoid issue)
        twitterClient?.deauthorize()
        
        
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"pptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("TwitterClient request token: Success!")
            
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            
            UIApplication.shared.open(url!, options: ["":""], completionHandler: nil)
            
            
        }, failure: { (errors: Error? ) -> Void in
                print("TwitterClient request token error: \(errors?.localizedDescription)")
                self.loginFailure?(errors!)
        })
    }
    
    
    func handleOpenURL(url: URL) {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken:
            
            requestToken, success: { (accessToken:BDBOAuth1Credential? ) in
            print("Appdelegate: Got the Access Token")
            
            
                self.currentAccount(success: { (user:User) in
                    
                    User.currentUser = user
                    self.loginSuccess?()
                    
                }, failure: { (errors:Error) in
                    self.loginFailure!(errors)
                })
                
        }, failure: { (errors:Error? ) in
            print("Errors: \(errors!.localizedDescription )")
            self.loginFailure!(errors!)
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
    
    func logout() {
        
        User.currentUser = nil
        deauthorize()
        
        //Switch back to main screen
        NotificationCenter.default.post(name: User.Notification_UserDidLogout, object: nil)
        
    }
    
    func createFavorite(id:NSNumber, success: @escaping ()->(), failure: @escaping (Error)->() ){

        
        print("1.1/favorites/create.json?id=\(id)")
        post("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            success()
            
            
        }, failure: { (task: URLSessionDataTask?, errors: Error) in
                
            failure(errors)
            
        })

        
    }
    
}
