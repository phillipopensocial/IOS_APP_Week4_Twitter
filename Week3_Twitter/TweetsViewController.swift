//
//  TweetsViewController.swift
//  Week3_Twitter
//
//  Created by Phillip Pang on 10/28/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onBackButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    var tweets: [Tweet]=[]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Setup table
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        //Get Tweet
        TwitterClient.sharedInstance!.homeTimeLine(success: { (tweets:[Tweet]) in
            
            print("\n\nTweetViewController")
            
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (errors:Error) in
                print(errors.localizedDescription)
        })
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.TweetCell", for: indexPath) as! TweetCell
        
        cell.gTextLabel.text = self.tweets[indexPath.row].text!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tweets.count) ?? 0
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
