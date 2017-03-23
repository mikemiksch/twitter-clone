//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Mike Miksch on 3/20/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweetStorage = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func profileButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "showProfileSegue", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Timeline"
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.dataSource = self
//        self.tableView.delegate = self
        updateTimeline()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    
        if segue.identifier == "showDetailSegue" {
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.tweetStorage[selectedIndex]
                
                guard let destinationController = segue.destination as? TweetDetailViewController else { return }
                
                destinationController.tweet = selectedTweet
            }
        }
//        if segue.identifier == "showProfileSegue" {
//                guard let destinationController = segue.destination as? ProfileViewController else { return }
//                destinationController
//        }
    }






    func updateTimeline() {
        self.activityIndicator.startAnimating()
        API.shared.getTweets { (tweets) in
            OperationQueue.main.addOperation {
                self.tweetStorage = tweets ?? []
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let userName = tweetStorage[indexPath.row].user?.name
        
        if let cell = cell as? TweetCell {
            cell.tweetText.text = tweetStorage[indexPath.row].text
        }
//        
//        cell.textLabel?.text = "\(tweetStorage[indexPath.row].text)"
//        
        if let userName = userName {
        cell.detailTextLabel?.text = "\(userName)"
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//    
    
}
