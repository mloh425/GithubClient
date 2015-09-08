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
    let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
    if let token = KeychainService.loadToken() {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
 //   if let url = NSURL(string: finalURL) { //Use string for just local resource?
      //Every request = a task -> Data task creates a GET HTTP request for the specified URL
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println(error.localizedDescription)
        } else if let httpResponse = response as? NSHTTPURLResponse { //httpResponse = NSURL response, need to downcast to get status code
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
          
        }
      }).resume() //The request will not be fired w/out the resume to get it started
 //     NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
 //   }
  }
  
  class func usersForSearchTerm(searchTerm : String, completionHandler: (String?, [User]?) -> (Void)) {
    let baseURL = "https://api.github.com/search/users"
    let finalURL = baseURL + "?q=\(searchTerm)"
    let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
    if let token = KeychainService.loadToken() {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
 //   if let url = NSURL(string: finalURL) { //Use string for just local resource?
      //Every request = a task -> Data task creates a GET HTTP request for the specified URL
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println(error.localizedDescription)
        } else if let httpResponse = response as? NSHTTPURLResponse { //httpResponse = NSURL response, need to downcast to get status code
          switch httpResponse.statusCode {
          case 200:
            let results = UserJSONParser.userInfoFromJSONData(data)
            completionHandler(nil, results)
          case 400...499:
            completionHandler("An unexpected error occured in the application", nil)
          case 500...599:
            completionHandler("An unexpected error occured with the servers", nil)
          default:
            completionHandler("Unexpected Error", nil)
          }
          
        }
      }).resume() //The request will not be fired w/out the resume to get it started
      //     NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
  //  }
  }
  
  class func myProfileForSearchTerm(completionHandler: (String?, MyProfile?) -> (Void)) {
    let baseURL = "https://api.github.com/user"
    let request = NSMutableURLRequest(URL: NSURL(string: baseURL)!)
    if let token = KeychainService.loadToken() {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }

    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if let error = error {
        println(error.localizedDescription)
      } else if let httpResponse = response as? NSHTTPURLResponse { //httpResponse = NSURL response, need to downcast to get status code
        switch httpResponse.statusCode {
        case 200:
          println(httpResponse.statusCode)
          let results = MyProfileJSONParser.myProfileInfoFromJSONData(data)
          completionHandler(nil, results)
        case 400...499:
          completionHandler("An unexpected error occured in the application", nil)
        case 500...599:
          completionHandler("An unexpected error occured with the servers", nil)
        default:
          completionHandler("Unexpected Error", nil)
        }
        
      }
    }).resume() //The request will not be fired w/out the resume to get it started
    //     NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
    //  }
  }
}

