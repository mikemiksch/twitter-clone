//
//  UserTImelineViewController.swift
//  TwitterClient
//
//  Created by Mike Miksch on 3/23/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweet : Tweet!
    var tweets = [Tweet]()
    
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Got this far!")
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)

        self.userTableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        self.userTableView.estimatedRowHeight = 50
        self.userTableView.rowHeight = UITableViewAutomaticDimension
        
        self.userTableView.dataSource = self
        self.userTableView.delegate = self

        if let user = self.tweet.user?.screenName {
            print("user screenName is: \(user)")
            API.shared.getTweetsFor(user) { (tweets) in
                if let tweets = tweets {
                    self.tweets = tweets
            
                }
            }
        }
    }
    
    func tableView(_ userTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ userTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        
        let tweet = self.tweets[indexPath.row]
        cell.tweet = tweet
        
        let userName = tweets[indexPath.row].user?.name
        if let userName = userName {
            cell.detailTextLabel?.text = "\(userName)"
        }
        return cell
    }

}
