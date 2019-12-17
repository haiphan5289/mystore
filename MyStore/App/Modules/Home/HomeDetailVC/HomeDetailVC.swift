//
//  HomeDetailVC.swift
//  MyStore
//
//  Created by MacbookPro on 12/16/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class HomeDetailVC: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var lbTitleItem: UILabel!
    @IBOutlet weak var btBack: UIButton!
    var model: ProductsFirebase!
    private var dataSource: Variable<[String]> = Variable([])
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRX()
        display()
        collection.delegate = self
        collection.register(UINib(nibName: "HomeDetailCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        if let model = self.model.arrayImage {
            dataSource.value = model
        }
        setupNavigation()
    }
    private func setupRX(){
        dataSource.asObservable().bind(to: collection.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeDetailCell
            if let url = URL(string: element) {
                cell.img.kf.setImage(with: url)
            }
            return cell
            }
            .disposed(by: disposeBag)
        
        btBack.rx.tap.bind { _ in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        visualize()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = Text.detail.localizedText
        let buttonBack = UIButton(type: .system)
        buttonBack.setImage(UIImage(named: "ic_back_arrow"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonBack)
        
        buttonBack.rx.tap.bind { _ in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    private func visualize() {
        lbTitleItem.text = Text.detail.localizedText
        lbTitle.text = Text.title.localizedText
        lbPrice.text = Text.price.localizedText
        lbDescription.text = Text.description.localizedText
    }
    private func display() {
        collection.layer.borderWidth = 1
        collection.layer.borderColor = CustomColor.greyLine.getColor().cgColor
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tfTitle.text = model.title
        tfPrice.text = model.price
        tvDescription.text = model.description
    }
}
extension HomeDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 32) / 3 - 20
        return CGSize(width: width, height: self.collection.frame.size.height - 20)
    }
}
