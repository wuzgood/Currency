//
//  NationalTableViewCell.swift
//  Currency
//
//  Created by Wuz Good on 27.10.2021.
//

import UIKit

class NationalTableViewCell: UITableViewCell {

    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var currencyCodeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
