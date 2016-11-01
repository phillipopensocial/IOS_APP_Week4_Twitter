//
//  TweetDetailViewController.swift
//  Week3_Twitter
//
//  Created by Phillip Pang on 10/31/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var gImageView: UIImageView!
    @IBOutlet weak var gUserLabel: UILabel!
    @IBOutlet weak var gCreateTimeLabel: UILabel!
    @IBOutlet weak var gTextLabel: UILabel!
    

    @IBOutlet weak var gRetweetIcon: UIButton!
    @IBOutlet weak var gReplyIcon: UIButton!
    @IBOutlet weak var gFavoriteIcon: UIButton!



    
    
    @IBOutlet weak var gIDLabel: UILabel!
    
    @IBOutlet weak var gFavoritedLabel: UILabel!
    
    
    
    @IBAction func onFavoriteAction(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance!.createFavorite(id: (self.tweet?.id)!, success: {
            print("Success!")
            
            //Switch button image
            if let image = UIImage(named: "like-action-on.png") {
                self.gFavoriteIcon.setImage(image, for: .normal)
            }
            
        }) { (errors:Error) in
            print("Error: \(errors.localizedDescription)")
        }
        
    }
    
    @IBAction func onReplyAction(_ sender: AnyObject) {
    }
    
    
    @IBAction func onRetweetAction(_ sender: AnyObject) {
        TwitterClient.sharedInstance!.retweet(id: (self.tweet?.id)!, success: {
            print("Success!")
            
            //Switch button image
            if let image = UIImage(named: "retweet-action-on.png") {
                self.gRetweetIcon.setImage(image, for: .normal)
            }
        }) { (errors:Error) in
            print("Error: \(errors.localizedDescription)")
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gTextLabel.text = self.tweet?.text!
        gUserLabel.text = self.tweet?.profileUserName!
        gCreateTimeLabel.text = self.tweet?.timestamp!.description
        
        if let anImageURL = (self.tweet?.profileImageUrlHttps) {
            self.gImageView.setImageWith( anImageURL )
        }
        
        gIDLabel.text = self.tweet?.id?.description
        gFavoritedLabel.text = self.tweet?.favorited

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
