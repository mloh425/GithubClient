//
//  RepoJSONParser.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/18/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import Foundation

class RepoJSONParser {
  class func repoInfoFromJSONData(jsonData : NSData) -> [Repo]? {
    var error : NSError?
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject] {
      var repos = [Repo]()
      if let itemsObject = rootObject["items"] as? [[String: AnyObject]] {
        for repoObject in itemsObject {
          if let name = repoObject["name"] as? String,
            htmlURL = repoObject["html_url"] as? String,
            ownerObject = repoObject["owner"] as? [String : AnyObject],
            avatarURL = ownerObject["avatar_url"] as? String {
              
              let repo = Repo(name : name, htmlURL : htmlURL, avatarURL : avatarURL)
              repos.append(repo)
          }
        }
      }
      return repos
    }
    if let error = error {
      //Check the error here.
    }
    return nil
  }
}