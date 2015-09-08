//
//  MyProfileJSONParser.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/22/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import Foundation

class MyProfileJSONParser {
  class func myProfileInfoFromJSONData(jsonData : NSData) -> MyProfile? {
    var error : NSError?
    if let myProfileObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject] {
      println(myProfileObject)
      var myProfile : MyProfile!
      var location = " "
      var bio = " "
      var hireable = false
      if let login = myProfileObject["login"] as? String,
        name = myProfileObject["name"] as? String,
        htmlURL = myProfileObject["html_url"] as? String,
        publicRepos = myProfileObject["public_repos"] as? Int,
        ownedPrivateRepos = myProfileObject["owned_private_repos"] as? Int,
        avatarURL = myProfileObject["avatar_url"] as? String {
          if let setLocation = myProfileObject["location"] as? String {
            location = setLocation
          }
          if let setBio = myProfileObject["bio"] as? String {
            bio = setBio
          }
          if let setHireable = myProfileObject["location"] as? Bool {
           hireable = setHireable
          }
          myProfile = MyProfile(login : login, name : name, htmlURL : htmlURL, location : location, bio : bio, avatarURL : avatarURL, hireable : hireable, publicRepos : publicRepos, ownedPrivateRepos : ownedPrivateRepos)
          return myProfile
      }
      return nil
  }
  if let error = error {
    //Check the error here.
  }
  return nil
}
}