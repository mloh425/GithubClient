//
//  ImageCache.swift
//  GithubClient
//
//  Created by Sau Chung Loh on 8/20/15.
//  Copyright (c) 2015 Sau Chung Loh. All rights reserved.
//

import UIKit

class ImageCache {
  var cache = [String : UIImage]()
  static let sharedCache = ImageCache()
  private init() {}
  
  func trackImage(name : String) -> UIImage? {
    if let image = cache[name] {
      return image
    }
    return nil
  }
  
  func addImage(name : String, image : UIImage) {
    cache[name] = image
  }
}