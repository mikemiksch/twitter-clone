//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Mike Miksch on 3/22/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userField: UILabel!
    @IBOutlet weak var tweetBody: UILabel!
    @IBAction func userTimelineButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: UserTimelineViewController.identifier, sender: sender)
    }
    
    
    var tweet : Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userField.text = self.tweet.user?.name ?? "Unknown"
        self.tweetBody.font = UIFont.preferredFont(forTextStyle: .headline)
        self.tweetBody.text = self.tweet.text
        if let profileImageURL = self.tweet.user?.profileImageURL {
            UIImage.fetchImageWith(profileImageURL) { (image) in
                self.userImage.image = image
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == UserTimelineViewController.identifier {
            if let selectedUser = self.tweet.user {
                guard let destinationController = segue.destination as? UserTimelineViewController else { return }
                destinationController.selectedUser = selectedUser
            }
        }
    }
}
