//
//  PostProductCell.swift
//  MyStore
//
//  Created by MacbookPro on 11/30/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class PostProductCell: UICollectionViewCell {

    @IBOutlet weak var imgSelect: UIImageView!
    @IBOutlet weak var btDelete: UIButton!
    private let disposeBag = DisposeBag()
//    var buttonAction: ((_ sender: Any) -> Void)?
    var buttonAction: ((_ sender: Any) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgSelect.layer.cornerRadius = CGFloat(Constant.radiusTextField.value)
        setupRX()
    }
    
    private func setupRX() {

    }
    @IBAction func btDeleteAction(_ sender: UIButton) {
        self.buttonAction?(sender)
    }
    
}
