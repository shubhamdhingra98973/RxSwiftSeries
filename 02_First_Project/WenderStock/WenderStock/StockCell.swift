//
//  StockCell.swift
//  WenderStock
//
//  Created by Apple on 27/01/21.
//

import UIKit

class StockCell: UITableViewCell {

    @IBOutlet weak var lblSymbols : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(_ stockPrice : StockPrice) throws{
        self.lblSymbols.text = stockPrice.symbol
        self.lblPrice.text = "\(try stockPrice.price.value())"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
