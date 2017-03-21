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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        updateTimeline()
    }

    func updateTimeline() {
        API.shared.getTweets { (tweets) in
            OperationQueue.main.addOperation {
                self.tweetStorage = tweets ?? []
            }
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
