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
  
  func setupWithQuote(quote: String, quoter: String) {
    quoterLabel.text = quoter
    quoteLabel.text = quote
  }
}
