//
//  QuoteBuilderViewController.swift
//  QuotePro
//
//  Created by KevinT on 2018-03-28.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

protocol SaveQuoteDelegate: class {
  func saveQuote(quote: Quote)
}

class QuoteBuilderViewController: UIViewController {

  @IBOutlet weak var quoteBuilderLabel: UILabel!
  @IBOutlet weak var quoterBuilderLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  
  var quote: Quote?
  var quoteView: QuoteView?
  
  weak var saveQuoteDelegate: SaveQuoteDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
        // Do any additional setup after loading the view.
    
//    load quoteView and add to view
    quoteView = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: nil)?.first! as? QuoteView
    self.view.addSubview(quoteView!)
    
    quoteView?.translatesAutoresizingMaskIntoConstraints = false
    let horizontalConstraint = NSLayoutConstraint(item: quoteView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
    let verticalConstraint = NSLayoutConstraint(item: quoteView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 75)
    let widthConstraint = NSLayoutConstraint(item: quoteView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.bounds.width)
    let heightConstraint = NSLayoutConstraint(item: quoteView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.bounds.height/2)
    view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    
    // return a quote from network
    let quoteManager = QuoteManager()
    quoteManager.forismaticNetworkRequest() {(quote: Quote) in
      self.quote = quote
      
//      return photo from network
      let photoManager = PhotoManager()
      photoManager.lorempixelNetworkRequest() {(image: UIImage) in
        let photo = Photo(photo: image)
        quote.photo = photo
        
        DispatchQueue.main.async {
          self.quoteView?.setupWithQuote(quote: quote)
        }
      }
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func saveButtonTouched(_ sender: UIBarButtonItem) {
    
//    pass quote and image back to populate table
    self.saveQuoteDelegate?.saveQuote(quote: self.quote!)

    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func changeQuoteButton(_ sender: UIButton) {
    
//    keep current photo
    let currentPhoto = Photo(photo: (quoteView?.imageView.image)!)
    
//    return new quote
    let quoteManager = QuoteManager()
    quoteManager.forismaticNetworkRequest() {(quote: Quote) in
      let quote = quote
      
      quote.photo = currentPhoto
      DispatchQueue.main.async {
        self.quoteView?.setupWithQuote(quote: quote)
      }
    }
  }
  
  @IBAction func changeImageButton(_ sender: UIButton) {
    
    // keep current quote
    let quote = Quote(quoteText: (quoteView?.quoteLabel.text)!, quoter: (quoteView?.quoterLabel.text)!)
    
      // return new photo
      let photoManager = PhotoManager()
      photoManager.lorempixelNetworkRequest() {(image: UIImage) in
        let photo = Photo(photo: image)
        quote.photo = photo
        
        DispatchQueue.main.async {
          self.quoteView?.setupWithQuote(quote: quote)
        }
      }
    }
  }
  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


