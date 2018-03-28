//
//  Quote.swift
//  QuotePro
//
//  Created by KevinT on 2018-03-28.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

class Quote: NSObject {
  
  var quoteText: String
  var quoter: String
  
  init(quoteText: String, quoter: String) {
    self.quoteText = quoteText
    self.quoter = quoter
  }

}
