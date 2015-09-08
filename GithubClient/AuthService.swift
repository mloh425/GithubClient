//
//  AuthService.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/18/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class AuthService {
  class func performInitialRequest() {
    //Opens URL in Safari, singleton
    // protocol: https:// domain: github.com endpoint: /login/oauth/authorize query?
    UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/login/oauth/authorize?client_id=\(kClientID)&redirect_uri=GithubClient://oauth&scope=user,repo")!)
  }
  
  class func exchangeCodeInURL(codeURL : NSURL) {
    if let let code = codeURL.query { //This is the token
      let request = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token?\(code)&client_id=\(kClientID)&client_secret=\(kClientSecret)")!) //First time giving clientSecret
      println(request.URL)
      request.HTTPMethod = "POST" //Sending data back to github so you have to post ***** how you make a post request
      request.setValue("application/json", forHTTPHeaderField: "Accept")
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse.statusCode)
          
          var jsonError : NSError?
          if let rootObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String: AnyObject],
            token = rootObject["access_token"] as? String {
              KeychainService.saveToken(token)
              //New stuff Notification Center 
              NSNotificationCenter.defaultCenter().postNotificationName(kTokenNotification, object: nil)
          //    println(token)
          }
        }
      }).resume()
    }
  }
}