//
//  HomeDetailCell.swift
//  MyStore
//
//  Created by MacbookPro on 12/17/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit

class HomeDetailCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.layer.cornerRadius = CGFloat(Constant.radiusTextField.value)
    }

}
