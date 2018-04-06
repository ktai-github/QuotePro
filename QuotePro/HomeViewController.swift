//
//  HomeViewController.swift
//  QuotePro
//
//  Created by KevinT on 2018-03-28.
//  Based on code by Chris Dean https://github.com/ChrisJohnDean/QuotePro
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SaveQuoteDelegate {
  
  @IBOutlet weak var quoteTableView: UITableView!
  var quoteArray = Array<Quote>() // populate tableview with saved quotes
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.quoteTableView.dataSource = self
    self.quoteTableView.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return quoteArray.count
  }
  
//  MARK: tableview functions
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var quoteTableViewCell = QuoteTableViewCell()
    
//    re-use cells for new table row of data
    quoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! QuoteTableViewCell
    
//    access each row of the array to populate table
    let quote = quoteArray[indexPath.row]
    
    quoteTableViewCell.quoteCellLabel.text = quote.quoteText
    quoteTableViewCell.quoterCellLabel.text = quote.quoter
    
    return quoteTableViewCell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
//    get the array element that correspond to the selected table row
    let quote = quoteArray[indexPath.row]
    
    shareQuoteImage(quote: quote)
  }

  func shareQuoteImage(quote: Quote) {
    let quoteView = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: nil)?.first! as! QuoteView
    quoteView.setupWithQuote(quote: quote)
    
//    render image with quoteView and its hierarchy
    UIGraphicsBeginImageContextWithOptions(quoteView.bounds.size, quoteView.isOpaque, quoteView.contentScaleFactor)
    quoteView.layer.render(in: UIGraphicsGetCurrentContext()!)
    quoteView.drawHierarchy(in: quoteView.bounds, afterScreenUpdates: true)
    
//    return rendered image and clean up
    let quoteImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
//    view controller for sharing and copying to another app that quoteView
    let activityViewController = UIActivityViewController(activityItems: [quoteImage!], applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    self.present(activityViewController, animated: true, completion: nil)
  }
  
  // MARK: save quote delegate function
  func saveQuote(quote: Quote) {
    quoteArray.append(quote)
    print(quote.quoteText)
    quoteTableView.reloadData()
  }

  // NAVIGATION: segue to Query Builder
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowQuoteBuilder" {
      let vc = segue.destination as! QuoteBuilderViewController
      vc.saveQuoteDelegate = self
    }
  }

}

