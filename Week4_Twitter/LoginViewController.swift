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
        
        let client = TwitterClient.sharedInstance!
        
        client.login(success: {
            
            //Login Success
            NotificationCenter.default.post(name: User.Notification_UserDidLogin, object: nil)
            
             //Get Account Info
             client.currentAccount(success: { (user: User) in
             
                 print("\n\n\nName: \(user.name)")
                 print("Screen Name: \(user.screenName)")
                 print("Profile URL: \(user.profileURL)")
                 print("description: \(user.tagLine)\n\n\n")
             
             }, failure: { (errors:Error) in
                print(errors.localizedDescription)
             })
             
             
             //Get Tweet
             client.homeTimeLine(success: { (tweets:[Tweet]) in
                
                 for tweet in tweets {
                 print(tweet.text)
                 }
                
             }, failure: { (errors:Error) in
                print(errors.localizedDescription)
             })


            
        }) { (errors: Error) in
                print ("Error: \(errors.localizedDescription)")
        }

        
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
