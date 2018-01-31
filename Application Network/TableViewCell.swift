//
//  TableViewCell.swift
//  Application Network
//
//  Created by Cody Dana on 1/30/18.
//  Copyright © 2018 Cody Dana. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(_ name: String, symbol: String){
        nameLabel.text = name
        symbolLabel.text = symbol
    }
}
