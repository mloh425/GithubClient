//
//  RepoSearchViewController.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/17/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  var repos = [Repo]()
  let imageQueue = NSOperationQueue()
  
  
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let webViewController = segue.destinationViewController as? WebViewViewController,
      indexPath = self.tableView.indexPathForSelectedRow() {
        let selectedRow = indexPath.row
        let selectedRepo = self.repos[selectedRow]
        webViewController.url = selectedRepo.htmlURL
    }
  }
}

//Mark: UISearchBarDelegate
extension RepoSearchViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    activityIndicator.startAnimating()
    GithubService.repositoriesForSearchTerm(searchBar.text, completionHandler: { (errorDescription, repos) -> (Void) in
      if let repos = repos {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
          self.repos = repos
          self.tableView.reloadData()
          self.activityIndicator.stopAnimating()
        }
      }
    })
  }
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.validateForURL()
  }
}

//Mark: UITableViewDataSource, UITableViewDelegate
extension RepoSearchViewController : UITableViewDataSource, UITableViewDelegate {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RepoCell", forIndexPath: indexPath) as! RepoCell
    var repo = repos[indexPath.row]
    cell.avatarImage.image = nil
    cell.tag++
    let tag = cell.tag
    cell.nameLabel.text = "Repository: " + repo.name
    cell.urlLabel.text = "Link: " + repo.htmlURL
    if let url = repo.avatarURL {
      if let image = ImageCache.sharedCache.trackImage(url) {
        if cell.tag == tag {
          cell.avatarImage.image = image
        }
      } else {
        imageQueue.addOperationWithBlock({ () -> Void in
          let image = ImageDownloader.downloadImage(repo)
          ImageCache.sharedCache.addImage(url, image: image!)
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            if cell.tag == tag {
              cell.avatarImage.image = image
              cell.avatarImage.layer.masksToBounds = true
              cell.avatarImage.layer.cornerRadius = 40
//              cell.avatarImage.layer.borderWidth = 1
//              cell.avatarImage.layer.borderColor = UIColor.blackColor().CGColor
            }
          })
        })
      }
    }
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    performSegueWithIdentifier("ShowWebVC", sender: nil)
  }
}
