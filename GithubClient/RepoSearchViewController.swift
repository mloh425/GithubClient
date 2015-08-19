//
//  RepoSearchViewController.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/17/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var repos = [Repo]()
  @IBOutlet weak var searchBar: UISearchBar!
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

//Mark: UISearchBarDelegate
extension RepoSearchViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    GithubService.repositoriesForSearchTerm(searchBar.text, completionHandler: { (errorDescription, repos) -> (Void) in
      if let repos = repos {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
          self.repos = repos
          self.tableView.reloadData()
        }
      }
    })
  }
}

extension RepoSearchViewController : UITableViewDataSource, UITableViewDelegate {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RepoCell", forIndexPath: indexPath) as! RepoCell
    var repo = repos[indexPath.row]
    cell.tag++
    let tag = cell.tag
    cell.nameLabel.text = repo.name
    cell.urlLabel.text = repo.htmlURL
    return cell
  }
}