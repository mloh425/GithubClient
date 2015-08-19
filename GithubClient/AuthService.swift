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
    if let let code = codeURL.query {
      let request = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token?\(code)&client_id=\(kClientID)&client_secret=\(kClientSecret)")!)
      println(request.URL)
      request.HTTPMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Accept")
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse.statusCode)
          
          var jsonError : NSError?
          if let rootObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String: AnyObject],
            token = rootObject["access_token"] as? String{
              println(token)
          }
        }
      }).resume()
    }
  }
}