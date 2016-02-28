//
//  UserProfileViewController.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/25/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: User!
    var tweets: [Tweet]!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var numberTweetsLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        nameLabel.text = String(user.name)
        usernameLabel.text = String(user.screenname)
        profileImage.setImageWithURL(NSURL(string: user.newImageUrl!)!)
        numberTweetsLabel.text = String(user.tweetCount!)
        followingLabel.text = String(user.followingCount!)
        followersLabel.text = String(user.followersCount!)
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            }, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TweetsTableViewCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return(self.tweets.count)
        }
        else{
            return 0
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
