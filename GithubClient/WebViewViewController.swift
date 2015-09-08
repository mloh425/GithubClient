//
//  WebViewViewController.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/20/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
 // var htmlURL: String!
  var url: String!
  override func viewDidLoad() {
    super.viewDidLoad()
    let webView = WKWebView(frame: view.frame)
    view.addSubview(webView)
    let urlRequest = NSURLRequest(URL: NSURL(string: url)!)
    webView.loadRequest(urlRequest)

    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
