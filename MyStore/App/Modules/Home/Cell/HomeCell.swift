//
//  HomeCell.swift
//  MyStore
//
//  Created by MacbookPro on 11/23/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgProduct.layer.cornerRadius = CGFloat(Constant.radiusTextField.value)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
