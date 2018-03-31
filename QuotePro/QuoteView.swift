//
//  QuoteView.swift
//  QuotePro
//
//  Created by KevinT on 2018-03-28.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

class QuoteView: UIView {
  
  @IBOutlet weak var quoterLabel: UILabel!
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  var view: UIView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func setupWithQuote(quote: Quote) {
    self.quoterLabel.text = quote.quoter
    self.quoteLabel.text = quote.quoteText
    
    //download image from url
  }

}
