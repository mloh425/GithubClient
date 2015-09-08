//
//  LoginViewController.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/18/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //Oberserver = self, selector = function to be fired, name: name of ....., nil
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "newToken", name: kTokenNotification, object: nil)
      
        // Do any additional setup after loading the view.
    }

    func newToken() {
      performSegueWithIdentifier("PresentMenu", sender: nil)
    }
    
  @IBAction func loginButton(sender: AnyObject) {
    
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: kTokenNotification, object: nil)
  }
}
