//
//  UserJSONParser.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/19/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import Foundation

class UserJSONParser {
  class func userInfoFromJSONData(jsonData : NSData) -> [User]? {
    var error : NSError?
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject] {
      var users = [User]()
      if let itemsObject = rootObject["items"] as? [[String: AnyObject]] {
        for item in itemsObject {
          if let login = item["login"] as? String,
            htmlURL = item["html_url"] as? String,
            avatarURL = item["avatar_url"] as? String {
              
              let user = User(login : login, htmlURL : htmlURL, avatarURL : avatarURL)
              users.append(user)
          }
        }
      }
      return users
    }
    if let error = error {
      //Check the error here.
    }
    return nil
  }
}