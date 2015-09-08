//
//  ToUserDetailAnimationController.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/20/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class ToUserDetailAnimationController: NSObject {

}

extension ToUserDetailAnimationController : UIViewControllerAnimatedTransitioning {
  //How long transition will take? Protocol 1
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }
  
  //This is the animation
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    //1) Get reference to a from and to VC
    if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UserSearchViewController, toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UserDetailViewController {
      //ContainerView comes with the fromVC's view already installed
      let containerView = transitionContext.containerView()
      
      toVC.view.alpha = 0
      containerView.addSubview(toVC.view)
    
      let indexPath = fromVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
      let userCell = fromVC.collectionView.cellForItemAtIndexPath(indexPath) as! UserCell
      
      //Convert usercell's frame to container view's coordinate space
      let snapShot = userCell.avatarImage.snapshotViewAfterScreenUpdates(false)
      snapShot.frame = containerView.convertRect(userCell.avatarImage.frame, fromCoordinateSpace: userCell.avatarImage.superview!)
      
      containerView.addSubview(snapShot) //Have snapshot ready to be moved in the right coordinates
      toVC.view.layoutIfNeeded() //Calculate layout for this View -> just to ensure that destination image view is in place before sending snapshot to go there.
      toVC.profileImage.hidden = true
      let destinationFrame = toVC.profileImage.frame
      
      UIView.animateWithDuration(0.4, animations: { () -> Void in
        snapShot.frame = destinationFrame
        toVC.view.alpha = 1
      }, completion: { (finished) -> Void in
        userCell.hidden = false
        toVC.profileImage.hidden = false
        snapShot.removeFromSuperview()
        if finished {
          transitionContext.completeTransition(finished)
        } else {
          transitionContext.completeTransition(finished)
        }
      })
    }
  }
}