//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Mike Miksch on 3/22/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageURL: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.shared.getUserAccount { (user) in
            OperationQueue.main.addOperation {
                self.user = user
                self.userName.text = self.user?.name
                self.userLocation.text = self.user?.location
//                if let urlString = user?.profileImageURL {
//                    let url = NSURL(string: urlString)
//                    let urlData = NSData(contentsOf: url as? URL)
//                    self.imageURL.image = UIImage(data: urlData as? Data)
//                }
            }
            
        }
        
    }
    
}

