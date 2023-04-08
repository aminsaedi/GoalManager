//
//  StockTableViewCell.swift
//  TableViewCustomizedCell
//
//  Created by Daniel Carvalho on 23/03/23.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    
    static let identifier = "StockTableViewCell"
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    
    @IBOutlet weak var lblPriceVariation: UILabel!
    
    @IBOutlet weak var imgPriceVariation: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCellContent( stock : StockModel ){
        
        lblCompanyName.text = stock.companyName
        lblPrice.text = "\(stock.price!)"
        
        if stock.priceVariation! > 0 {
            imgPriceVariation.image = UIImage(systemName: "arrow.up")
            imgPriceVariation.tintColor = .systemGreen
            lblPriceVariation.text = "+\(stock.priceVariation!)%"
        } else if stock.priceVariation! < 0 {
            imgPriceVariation.image = UIImage(systemName: "arrow.down")
            imgPriceVariation.tintColor = .systemRed
            lblPriceVariation.text = "\(stock.priceVariation!)%"
        } else {
            imgPriceVariation.image = UIImage(systemName: "equal")
            imgPriceVariation.tintColor = .white
            lblPriceVariation.text = "0.0%"
        }
        
    }
    
    
}
