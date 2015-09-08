//
//  ImageDownloader.swift
//  Github Client
//
//  Created by Sau Chung Loh on 8/7/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class ImageDownloader {
  
  class func downloadImage(repository : Repo) -> (UIImage?) {
    if let avatarURL = repository.avatarURL,
      let imageURL = NSURL(string: avatarURL),
      let imageData = NSData(contentsOfURL: imageURL),
      let image = UIImage(data: imageData) {
        var size = determineProfileImageSize()
        let resizedImage = ImageResizer.resizeImage(image, size: size)
        return (resizedImage)
    }
    return nil
  }
  
  class func downloadImage(user : User) -> (UIImage?) {
    if let avatarURL = user.avatarURL,
      let imageURL = NSURL(string: avatarURL),
      let imageData = NSData(contentsOfURL: imageURL),
      let image = UIImage(data: imageData) {
        var size = determineProfileImageSize()
        let resizedImage = ImageResizer.resizeImage(image, size: size)
        return (resizedImage)
    }
    return nil
  }
  
  class func downloadImage(avatarURL : String) -> (UIImage?) {
    let imageURL = NSURL(string: avatarURL)
    let imageData = NSData(contentsOfURL: imageURL!)
    if let image = UIImage(data: imageData!) {
      var size = determineProfileImageSize()
      let resizedImage = ImageResizer.resizeImage(image, size: size)
      return (resizedImage)
    }
    return nil
  }
  
  
  //Returns the proper dimensions for the profile picture based on the device's screen size
  class func determineProfileImageSize() -> CGSize {
    var size : CGSize
    switch UIScreen.mainScreen().scale {
    case 2:
      size = CGSize(width: 160, height: 160)
    case 3:
      size = CGSize(width: 240, height: 240)
    default:
      size = CGSize(width: 80, height: 80)
    }
    return size
  }
}