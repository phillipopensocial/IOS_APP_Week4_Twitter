//
//  UserProfileViewController.swift
//  Week4_Twitter
//
//  Created by Phillip Pang on 11/6/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var user:User?
    @IBOutlet weak var gProfileURL: UIImageView!
    @IBOutlet weak var gProfileBGURL: UIImageView!
    @IBOutlet weak var gScreenName: UILabel!
    @IBOutlet weak var gFollowingCount: UILabel!
    @IBOutlet weak var gFollowersCount: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if user != nil{
            
            if user!.profileURL != nil {
                gProfileURL.setImageWith(user!.profileURL!)
            }
            
            if user!.profileBGURL != nil {
                gProfileBGURL.setImageWith(user!.profileBGURL!)
            }
            
            gScreenName.text = user!.name
            gFollowingCount.text = user!.followingCount?.description
            gFollowersCount.text = user!.followersCount?.description
            
        }
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
