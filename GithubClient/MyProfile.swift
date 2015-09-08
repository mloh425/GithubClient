//
//  MyProfile.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/22/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import Foundation

struct MyProfile {
  let login : String
  let name : String
  let htmlURL : String
  let location : String
  let bio : String
  let avatarURL : String?
  let hireable : Bool
  let publicRepos : Int
  let ownedPrivateRepos : Int
}