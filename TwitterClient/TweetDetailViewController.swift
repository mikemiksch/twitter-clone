//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Mike Miksch on 3/22/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var userField: UILabel!
    @IBOutlet weak var retweetedFlag: UILabel!
    @IBOutlet weak var tweetBody: UILabel!
    
    
    var tweet : Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userField.text = self.tweet.user?.name ?? "Unknown"
        self.tweetBody.font = UIFont.preferredFont(forTextStyle: .headline)
        self.tweetBody.text = self.tweet.text
        if self.tweet.retweeted > 0 {
            self.retweetedFlag.text = "Retweeted"
        } else {
            self.retweetedFlag.text = ""
        }

    }
}
