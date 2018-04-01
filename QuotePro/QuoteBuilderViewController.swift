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
  //  let view:QuoteView = QuoteView(frame: CGRect(x: 0, y: 0, width:  self.view.frame.width, height: 150))
   
    quoteView = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: nil)?.first! as? QuoteView
    self.view.addSubview(quoteView!)
    
    quoteView?.translatesAutoresizingMaskIntoConstraints = false

    let horizontalConstraint = NSLayoutConstraint(item: quoteView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
    let verticalConstraint = NSLayoutConstraint(item: quoteView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 75)
    let widthConstraint = NSLayoutConstraint(item: quoteView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.bounds.width)
    let heightConstraint = NSLayoutConstraint(item: quoteView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.bounds.height/2)
    view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    
    let quoteManager = QuoteManager()
    quoteManager.forismaticNetworkRequest() {(quote: Quote) in
      let quote = quote
      
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
    
    guard let unwQuoter = quoteView?.quoterLabel.text,
      let unwQuoteText = quoteView?.quoteLabel.text
      else { return }
    
    quote = Quote(quoteText: unwQuoteText, quoter: unwQuoter)
    //  func saveQuote(quote: Quote) {

    self.saveQuoteDelegate?.saveQuote(quote: quote!)

    self.navigationController?.popViewController(animated: true)
//    self.navigationController?.popToViewController((self.navigationController?.viewControllers[0])!, animated: true)
  }
  
  @IBAction func changeQuoteButton(_ sender: UIButton) {
    let oldPhoto = Photo(photo: (quoteView?.imageView.image)!)
    
    let quoteManager = QuoteManager()
    quoteManager.forismaticNetworkRequest() {(quote: Quote) in
      let quote = quote
      quote.photo = oldPhoto
      DispatchQueue.main.async {
        self.quoteView?.setupWithQuote(quote: quote)
        
      }
    }
    
  }
  
  @IBAction func changeImageButton(_ sender: UIButton) {
    let quote = Quote(quoteText: (quoteView?.quoteLabel.text)!, quoter: (quoteView?.quoterLabel.text)!)
    
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


