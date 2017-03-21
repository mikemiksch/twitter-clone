//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Mike Miksch on 3/20/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweetStorage = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        updateTimeline()
    }
//
//        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
//            if(success) {
//                guard let tweets = tweets else {
//                    fatalError("Tweets came back nil")
//                }
//                for tweet in tweets {
//                    tweetStorage.append(tweet)
//                }
//            }
//        }
//
//    }
//    
        
    func updateTimeline() {
        API.shared.getTweets { (tweets) in
            self.tweetStorage = tweets ?? []
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let userName = tweetStorage[indexPath.row].user?.name
        
        cell.textLabel?.text = "\(tweetStorage[indexPath.row].text)"
        
        if let userName = userName {
        cell.detailTextLabel?.text = "\(userName)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
}
