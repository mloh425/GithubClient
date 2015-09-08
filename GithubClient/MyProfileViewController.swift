//
//  MyProfileViewController.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/22/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
  var myProfile : MyProfile!
  
  @IBOutlet weak var loginLabel: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var bioTextField: UITextView!

  @IBOutlet weak var linkButton: UIButton!
  @IBOutlet weak var publicRepoLabel: UILabel!
  
  @IBOutlet weak var privateRepoLabel: UILabel!
  
  @IBOutlet weak var hireableLabel: UILabel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    myProfile = fetchProfile()
    
// //   myProfile.name

        // Do any additional setup after loading the view.
  }
  
  func fetchProfile () -> MyProfile?{
    GithubService.myProfileForSearchTerm { (errorDescription, myProfile) -> (Void) in
      if let errorDescription = errorDescription {
        
      } else if let profile = myProfile {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.myProfile = profile
          self.setFields()
          if let image = ImageDownloader.downloadImage(self.myProfile.avatarURL!) {
            self.profileImage.image = image
            self.profileImage.layer.masksToBounds = true
            self.profileImage.layer.cornerRadius = 75
          }
        })
      }
    }
    return nil 
  }
  
  func setFields() {
    loginLabel.text = myProfile.login
    nameLabel.text = myProfile.name
    locationLabel.text = myProfile.location
    bioTextField.text = myProfile.bio
    linkButton.setTitle(myProfile.htmlURL, forState: .Normal)
    publicRepoLabel.text = "\(myProfile.publicRepos)"
    privateRepoLabel.text = "\(myProfile.ownedPrivateRepos)"
    hireableLabel.text = myProfile.hireable ? "Yes" : "No"
    
  }
  @IBAction func linkButtonPressed(sender: UIButton) {
    performSegueWithIdentifier("ShowWebController", sender: sender)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowWebController" {
      if let destination = segue.destinationViewController as? WebViewViewController {
        destination.url = myProfile.htmlURL
      }
    }
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
