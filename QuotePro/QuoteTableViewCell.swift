//
//  QuoteTableViewCell.swift
//  QuotePro
//
//  Created by KevinT on 2018-03-28.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

  @IBOutlet weak var quoteCellLabel: UILabel!
  @IBOutlet weak var quoterCellLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
