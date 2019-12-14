//  File name   : PostProductVC.swift
//
//  Author      : MacbookPro
//  Created date: 11/29/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import UIKit
import RxSwift
import RxCocoa

protocol PostProductPresentableListener: class {
    // todo: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PostProductVC: UIViewController, PostProductPresentable, PostProductViewControllable {
    private struct Config {
    }
    
    /// Class's public properties.
    weak var listener: PostProductPresentableListener?
    private let disposeBag = DisposeBag()

    // MARK: View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        setupRX()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
    }
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbDescriptionText: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btSubmit: UIButton!
    
    
    /// Class's private properties.
}

// MARK: View's event handlers
extension PostProductVC {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: Class's public methods
extension PostProductVC {
}

// MARK: Class's private methods
private extension PostProductVC {
    private func localize() {
        // todo: Localize view's here.
        lbTitle.text = Text.title.localizedText
        lbPrice.text = Text.price.localizedText
        lbDescription.text = Text.description.localizedText
        tfTitle.placeholder = Text.inputTitle.localizedText
        tfPrice.placeholder = Text.inputPrice.localizedText
        lbDescriptionText.text = Text.inputDescription.localizedText
        lbDescriptionText.layer.borderWidth = CGFloat(Constant.lineTextFieldBorder.value)
        lbDescriptionText.layer.borderColor = CustomColor.greyLine.getColor().cgColor
        lbDescriptionText.layer.cornerRadius = CGFloat(Constant.radiusTextField.value)
        lbDescriptionText.clipsToBounds = true
        btSubmit.setTitle(Text.postProduct.localizedText, for: .normal)
        btSubmit.layer.cornerRadius = CGFloat(Constant.btRadiusLogin.value)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PostProductCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
    }
    private func visualize() {
        // todo: Visualize view's here.
    }
    private func setupRX() {
        btSubmit.rx.tap.bind { _ in
            let tableProduct = fw.share.dataBase.child("Products").childByAutoId()
            let infoUser: Dictionary<String,Any> = ["title": self.tfTitle.text,
                                                    "price": self.tfPrice.text,
                                                    "description": self.lbDescriptionText.text]
            tableProduct.setValue(infoUser)
            
        }.disposed(by: disposeBag)
    }
}
extension PostProductVC: UICollectionViewDelegate {
}
extension PostProductVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .brown
        return cell
    }
    
}
extension PostProductVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 32) / 3 - 10
        return CGSize(width: width, height: self.collectionView.frame.size.height - 20)
    }
}
