//
//  QuoteBuilderViewController.swift
//  QuotePro
//
//  Created by KevinT on 2018-03-28.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

protocol SaveQuoteDelegate {
  func saveQuote(quote: Quote)
}

class QuoteBuilderViewController: UIViewController {

  @IBOutlet weak var quoteBuilderLabel: UILabel!
  @IBOutlet weak var quoterBuilderLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  
  var quote: Quote?
  
  var saveQuoteDelegate: SaveQuoteDelegate?
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func saveButtonTouched(_ sender: UIBarButtonItem) {
    
    guard let unwQuoter = quoterBuilderLabel.text, let unwQuoteText = quoteBuilderLabel.text else { return }
    
    quote = Quote(quoteText: unwQuoteText, quoter: unwQuoter)
    
    saveQuoteDelegate?.saveQuote(quote: quote!)

    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func changeQuoteButton(_ sender: UIButton) {
    
  }
  
  @IBAction func changeImageButton(_ sender: UIButton) {
    
  }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
