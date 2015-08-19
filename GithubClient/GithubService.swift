//
//  GithubService.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/17/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import Foundation

class GithubService {
  class func repositoriesForSearchTerm(searchTerm : String, completionHandler: (String?, [Repo]?) -> (Void)) {
    let baseURL = "https://api.github.com/search/repositories" //Contains protocol, domain, and endpoint for search, correct protocol is highly important "http(s)"
    //let baseURL = "http://localhost:3000"
    let finalURL = baseURL + "?q=\(searchTerm)" //append the query term w/ search term in it
    if let url = NSURL(string: finalURL) { //Use string for just local resource?
      //Every request = a task -> Data task creates a GET HTTP request for the specified URL
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println(error.localizedDescription)
        } else if let httpResponse = response as? NSHTTPURLResponse { //httpResponse = NSURL response, need to downcast to get status code
         // println(httpResponse.statusCode)
          switch httpResponse.statusCode {
          case 200:
            let results = RepoJSONParser.repoInfoFromJSONData(data)
            completionHandler(nil, results)
          case 400...499:
            completionHandler("An unexpected error occured in the application", nil)
          case 500...599:
            completionHandler("An unexpected error occured with the servers", nil)
          default:
            completionHandler("Unexpected Error", nil)
          }
          //switch to handle status code
        }
      }).resume() //The request will not be fired w/out the resume to get it started
    }
  }
  
//  class func statusCodeHandler(data : NSData, completionHandler: (String?, [Repo]?) -> (Void)) {
//    switch httpResponse.statusCode {
//    case 200:
//      let results = RepoJSONParser.repoInfoFromJSONData(data)
//      completionHandler(nil, results)
//    case 400...499:
//      completionHandler("An unexpected error occured in the application", nil)
//    case 500...599:
//      completionHandler("An unexpected error occured with the servers", nil)
//    default:
//      completionHandler("Unexpected Error", nil)
//    }
//
//  }
}