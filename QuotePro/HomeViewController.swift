//
//  HomeViewController.swift
//  QuotePro
//
//  Created by KevinT on 2018-03-28.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

var quoteArray = [Quote]()

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SaveQuoteDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let statusTableViewCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//    loadDataForView()
//    statusTableViewCell.buddyNameLabel.text = quoteArray[indexPath.row][0] as? String
//    statusTableViewCell.netAmountLabel.text = quoteArray[indexPath.row][3] as? String
    
    return statusTableViewCell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }

  //MARK: save quote delegate function
  func saveQuote(quote: Quote) {
    quoteArray.append(quote)
  }


}

