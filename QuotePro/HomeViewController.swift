//
//  HomeViewController.swift
//  QuotePro
//
//  Created by KevinT on 2018-03-28.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SaveQuoteDelegate {
  
  @IBOutlet weak var quoteTableView: UITableView!
  var quoteArray = Array<Quote>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.quoteTableView.dataSource = self
    self.quoteTableView.delegate = self
//    self.quoteTableView.reloadData()
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return quoteArray.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var quoteTableViewCell = QuoteTableViewCell()
      
    quoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! QuoteTableViewCell
    
    let quote = quoteArray[indexPath.row]
    
    quoteTableViewCell.quoteCellLabel.text = quote.quoteText
    quoteTableViewCell.quoterCellLabel.text = quote.quoter
    
    return quoteTableViewCell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let quote = quoteArray[indexPath.row]
    shareQuoteImage(quote: quote)
  }

  func shareQuoteImage(quote: Quote) {
    //  DispatchQueue.main.async {
    let quoteView = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: nil)?.first! as! QuoteView
    
    quoteView.setupWithQuote(quote: quote)
    UIGraphicsBeginImageContextWithOptions(quoteView.bounds.size, quoteView.isOpaque, quoteView.contentScaleFactor)
    quoteView.layer.render(in: UIGraphicsGetCurrentContext()!)
    quoteView.drawHierarchy(in: quoteView.bounds, afterScreenUpdates: true)
    
    let quoteImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    let activityViewController = UIActivityViewController(activityItems: [quoteImage!], applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    self.present(activityViewController, animated: true, completion: nil)
    // }  }
  }
  
  //MARK: save quote delegate function
  func saveQuote(quote: Quote) {
    quoteArray.append(quote)
    print(quote.quoteText)
    quoteTableView.reloadData()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowQuoteBuilder" {
      let vc = segue.destination as! QuoteBuilderViewController
      vc.saveQuoteDelegate = self
    }
  }

}

