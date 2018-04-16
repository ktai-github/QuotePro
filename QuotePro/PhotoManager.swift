//
//  PhotoManager.swift
//  QuotePro
//
//  Based on code by Chris Dean https://github.com/ChrisJohnDean/QuotePro
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

class PhotoManager: NSObject {
  func lorempixelNetworkRequest(completionHandler: @escaping (UIImage) -> Void) {
    
    if let url = URL(string: "https://lorempixel.com/400/200/sports/") {
      
      let data = try? Data(contentsOf: url)
      if let imageData = data, let image = UIImage(data: imageData) {
        
        completionHandler(image)
      }
    }
  }
}
