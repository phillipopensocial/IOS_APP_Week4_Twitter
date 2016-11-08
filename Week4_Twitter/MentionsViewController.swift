//
//  MentionsViewController.swift
//  Week4_Twitter
//
//  Created by Phillip Pang on 11/7/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register common cell
        //tableView.register(UINib(nibName: "CommonTweetCell", bundle:nil), forCellReuseIdentifier: "CommonTweetCell")
        

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension

        //Refresh Control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadTweets(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        
        // Do any additional setup after loading the view.
        //Get Tweet
        reloadTweets(refreshControl: refreshControl)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.CommonTweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = self.tweets[indexPath.row]
        cell.gTextLabel.text = self.tweets[indexPath.row].text!
        cell.gUserLabel.text = self.tweets[indexPath.row].profileUserName!
        cell.gCreateTimeLabel.text = self.tweets[indexPath.row].timestamp?.description
        
        if let anImageURL = (self.tweets[indexPath.row].profileImageUrlHttps) {
            cell.gImageView.setImageWith( anImageURL )
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tweets.count) ?? 0
    }

    func reloadTweets(refreshControl: UIRefreshControl){
        
        TwitterClient.sharedInstance!.mentionsTimeLine(success: { (tweets:[Tweet]) in
            
            print("\n\nMentionsViewController")
            
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text)
            }
            
            self.tableView.reloadData()
            refreshControl.endRefreshing()
            
            }, failure: { (errors:Error) in
                print(errors.localizedDescription)
        })
    }

}
