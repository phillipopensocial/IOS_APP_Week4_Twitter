//
//  MenuViewController.swift
//  Week4_Twitter
//
//  Created by Phillip Pang on 11/3/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var firstNavigationController: UIViewController!
    private var secondNavigationController: UIViewController!
    private var thirdNavigationController: UIViewController!
    
    var titles = //["Green","Blue","Orange"]
        ["Profile","Home Timeline", "Mentions View"]
    var viewControllers: [UIViewController] = []
    var hamburgerViewController: HamburgerViewController!


    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //Create instances
        firstNavigationController = storyboard.instantiateViewController(withIdentifier: "UserProfileNavigationController")
        secondNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        thirdNavigationController = storyboard.instantiateViewController(withIdentifier: "mentionsNavigationController")
        
        //Custom adjustment
        ((firstNavigationController as! UINavigationController).viewControllers[0] as! UserProfileViewController).user = User.currentUser
        
        //Add instances
        viewControllers.append(firstNavigationController)
        viewControllers.append(secondNavigationController)
        viewControllers.append(thirdNavigationController)
        
        //Set to the initial view
        hamburgerViewController.contentViewController = viewControllers[ 0 ]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.MenuCell", for: indexPath) as! MenuCell
        
        cell.menuTextLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Unselect the row for effect
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
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
