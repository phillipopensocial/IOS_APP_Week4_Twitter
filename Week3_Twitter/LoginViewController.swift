//
//  LoginViewController.swift
//  Week3_Twitter
//
//  Created by Phillip Pang on 10/26/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    @IBAction func onLoginButton(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "KvwIhQcx88dGBZmzETQTNH57C", consumerSecret: "tSwf38Re0RvX1W2CKFsYJv3uiRbpMQlPWyDXNWY2WGy10pNfnA")
        
        twitterClient?.deauthorize()
        
        let callbackURL = URL(string: "mytwitterdemo://oauth")
        print (callbackURL)
            
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: callbackURL, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
                print("TwitterClient request token: Success!")
            
            
                let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            
                UIApplication.shared.open(url!, options: ["":""], completionHandler: nil)
            
            
            }, failure: { (errors: Error? ) -> Void in
                print("TwitterClient request token error: \(errors)")
        })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
