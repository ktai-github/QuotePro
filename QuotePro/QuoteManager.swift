//
//  QuoteManager.swift
//  QuotePro
//
//  Created by KevinT, Chris Dean on 2018-03-28.
//  Copyright © 2018 KevinT. All rights reserved.
//

//import UIKit
import Foundation

class QuoteManager {
  
  func forismaticNetworkRequest(completionHandler: @escaping (Quote) -> Void) {
    
    var quote: Quote!
    
    guard let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json") else {return}
    let request = NSURLRequest(url: url)
    let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
      
      guard let data = data else {
        print("Received error: \(String(describing: error?.localizedDescription))")
        return
      }
      
      if let error = error {
        print("error during datatask to forismatic api \(String(describing: error))")
        return
      }
      quote = self.parseJsonData(data: data)
      completionHandler(quote)
    }
    dataTask.resume()
  }
  
  func parseJsonData(data: Data) -> Quote {
    
    let defaultQuoteObject = Quote(quoteText: "Always sanitize used iPads.", quoter: "Kevin")
    
    guard let quoteDictFromJsonAny = try? JSONSerialization.jsonObject(with: data, options: []), let quoteDictFromJson = quoteDictFromJsonAny as? [String:String] else {
      print("data is not json")
      return defaultQuoteObject
    }
    
    guard let author = quoteDictFromJson["quoteAuthor"] else {return defaultQuoteObject}
    guard let quoteText = quoteDictFromJson["quoteText"] else {return defaultQuoteObject}
    
    let quote = Quote(quoteText: quoteText, quoter: author)
    return quote
  }
}
