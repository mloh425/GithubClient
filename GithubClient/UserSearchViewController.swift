//
//  UserSearchViewController.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/19/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var users = [User]()
  let imageQueue = NSOperationQueue()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    collectionView.dataSource = self
  //  collectionView.delegate = self
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.delegate = self
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.delegate = nil
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowUserDetail" {
      if let destination = segue.destinationViewController as? UserDetailViewController,
        indexPath = collectionView.indexPathsForSelectedItems().first as? NSIndexPath {
          let user = users[indexPath.row]
          destination.selectedUser = user
      }
    }
  }
  
}

extension UserSearchViewController : UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  
  func setUpCellImage(cell : UserCell) {
    cell.avatarImage.layer.masksToBounds = true
    cell.avatarImage.layer.cornerRadius = 40
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      cell.alpha = 1
    })
    
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
    var user = users[indexPath.row]
    
    cell.avatarImage.image = nil
    cell.hidden = false
    cell.alpha = 0
    
    cell.tag++
    let tag = cell.tag
    
    if let url = user.avatarURL {
      if let image = ImageCache.sharedCache.trackImage(url) {
        if cell.tag == tag {
          cell.avatarImage.image = image
          self.setUpCellImage(cell)
        }
      } else {
        imageQueue.addOperationWithBlock({ () -> Void in
          let image = ImageDownloader.downloadImage(user)
          ImageCache.sharedCache.addImage(url, image: image!)
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            if cell.tag == tag {
              cell.avatarImage.image = image
              self.setUpCellImage(cell)
            }
          })
        })
      }
    }
    return cell
  }
}

extension UserSearchViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    activityIndicator.startAnimating()
    GithubService.usersForSearchTerm(searchBar.text, completionHandler: { (errorDescription, users) -> (Void) in
      if let errorDescription = errorDescription {
        
      } else if let users = users {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.users = users
          self.collectionView.reloadData()
          self.activityIndicator.stopAnimating()
        })
      }
    })
  }
  //Regex stuff
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.validateForURL()
  }
}

extension UserSearchViewController : UINavigationControllerDelegate {
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    if toVC is UserSearchViewController { //Check to see what the class you're going to IS
//      return ToUserDetailAnimationController()
//    }
//    return nil
    
  return toVC is UserDetailViewController ? ToUserDetailAnimationController() : nil
  }
}