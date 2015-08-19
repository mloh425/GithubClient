//
//  GithubJSONParser.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/18/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import Foundation

class GithubJSONParser {
  class func tweetsFromJSONData(jsonData : NSData) -> []? {
    
    var error : NSError?
    
    //Coverts ('serializes') data into native types for swift
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]] {
      var tweets = [Tweet]()
      for tweetObject in rootObject {
        if let text = tweetObject["text"] as? String,
          userInfo = tweetObject["user"] as? [String : AnyObject],
          screenName = userInfo["screen_name"] as? String,
          id = tweetObject["id_str"] as? String,
          username = userInfo["name"] as? String,
          location = userInfo["location"] as? String, //////////////////
          profileImageURL = userInfo["profile_image_url_https"] as? String {
            
            //If the tweet is a retweet, set all of the Tweet 'rt' properties
            if let retweetObject = tweetObject["retweeted_status"] as? [String : AnyObject],
              rtText = retweetObject["text"] as? String,
              rtUserInfo = retweetObject["user"] as? [String : AnyObject],
              rtScreenName = rtUserInfo["screen_name"] as? String,
              rtId = retweetObject["id_str"] as? String,
              rtUsername = rtUserInfo["name"] as? String,
              rtLocation = rtUserInfo["location"] as? String, //////////////////
              rtProfileImageURL = rtUserInfo["profile_image_url_https"] as? String {
                
                let rtProfileImage = ImageDownloader.downloadImage(rtProfileImageURL)
                
                let rtweet = Tweet(text: text, username: username, id: id, location: location, profileImageURL: profileImageURL, profileImage: nil, screenName : screenName, isARetweet: true, rtText: rtText, rtUsername: rtUsername, rtId: rtId, rtLocation: rtLocation, rtProfileImageURL : rtProfileImageURL, rtProfileImage : rtProfileImage, rtScreenName : rtScreenName, isAQuote: false, qtText: nil, qtUsername: nil, qtId: nil, qtLocation: nil,  qtProfileImageURL: nil, qtProfileImage: nil, qtScreenName : nil)
                
                tweets.append(rtweet)
                
                //If it tweet is a quote, set all of the Tweet 'qt' properties
            } else if let quoteObject = tweetObject["quoted_status"] as? [String : AnyObject],
              qtText = quoteObject["text"] as? String,
              qtUserInfo = quoteObject["user"] as? [String : AnyObject],
              qtScreenName = qtUserInfo["screen_name"] as? String,
              qtId = quoteObject["id_str"] as? String,
              qtUsername = qtUserInfo["name"] as? String,
              qtLocation = qtUserInfo["location"] as? String, //////////////////
              qtProfileImageURL = qtUserInfo["profile_image_url_https"] as? String {
                
                let qtProfileImage = ImageDownloader.downloadImage(qtProfileImageURL)
                
                let qtweet = Tweet(text: text, username: username, id: id, location: location, profileImageURL: profileImageURL, profileImage: nil, screenName : screenName, isARetweet: false, rtText: nil, rtUsername: nil, rtId: nil, rtLocation: nil, rtProfileImageURL : nil, rtProfileImage : nil, rtScreenName : nil, isAQuote: true, qtText: qtText, qtUsername: qtUsername, qtId: qtId, qtLocation: qtLocation,  qtProfileImageURL: qtProfileImageURL, qtProfileImage: qtProfileImage, qtScreenName : qtScreenName)
                
                tweets.append(qtweet)
                
                //If it is just a regular tweet, set its properties
            } else {
              let tweet = Tweet(text: text, username: username, id: id, location: location, profileImageURL: profileImageURL, profileImage: nil, screenName : screenName, isARetweet: false, rtText: nil, rtUsername: nil, rtId: nil, rtLocation: nil, rtProfileImageURL : nil, rtProfileImage : nil, rtScreenName : nil, isAQuote: false, qtText: nil, qtUsername: nil, qtId: nil, qtLocation: nil,  qtProfileImageURL: nil, qtProfileImage: nil, qtScreenName : nil)
              tweets.append(tweet)
            }
        }
      }
      return tweets
    }
    if let error = error {
      //Check the error here.
    }
    return nil
  }
}