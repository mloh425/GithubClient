//
//  UserDetailViewController.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/20/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

  @IBOutlet weak var linkButton: UIButton!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  var selectedUser: User!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      profileImage.image = ImageCache.sharedCache.trackImage(selectedUser.avatarURL!)
      profileImage.layer.masksToBounds = true
      profileImage.layer.cornerRadius = 100
      profileImage.layer.borderWidth = 2
      profileImage.layer.borderColor = UIColor.blackColor().CGColor
      
      userNameLabel.text = selectedUser.login
      linkButton.setTitle(selectedUser.htmlURL, forState: .Normal)
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowGitWebView" {
      if let destination = segue.destinationViewController as? WebViewViewController {
        destination.url = selectedUser.htmlURL
      }
    }
  }
  @IBAction func goToLinkPressed(sender: UIButton) {
    performSegueWithIdentifier("ShowGitWebView", sender: sender)
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
