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
import Firebase

protocol PostProductPresentableListener: class {
    // todo: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func routeToProfile()
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
//        setupNavigation()
        self.listImage.append(UIImage(named: "uploadimage")!)
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
    @IBOutlet weak var btCacnel: UIButton!
    private var listImage: [UIImage] = []
    private var isHasImage: Bool = false
    private var indexPathSelect: IndexPath!
    
    
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
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = CustomColor.greyLine.getColor().cgColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PostProductCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    private func visualize() {
        // todo: Visualize view's here.
    }
    private func setupRX() {
        btSubmit.rx.tap.bind { _ in
            DispatchQueue.main.async {
                let tableProduct = fw.share.dataBase.child(FirebaseTable.products.getTableUser()).childByAutoId()
                self.listImage.removeLast()
                self.getArrayImage(completion: { (array)  in
                    let infoUser: Dictionary<String,Any> = ["title": self.tfTitle.text,
                                                            "price": self.tfPrice.text,
                                                            "description": self.lbDescriptionText.text,
                                                            "arrayImage": array]
                    tableProduct.setValue(infoUser)
                    return array
                })
            }
            }.disposed(by: disposeBag)
        
        btCacnel.rx.tap.bind { _ in
            self.listener?.routeToProfile()
        }.disposed(by: disposeBag)
    }
    
    private func getArrayImage(completion: @escaping ([String]) -> [String]){
        var arrayStringImage: [String] = []
        var count = 0
        for item in self.listImage {
            let randomIntFrom0To10 = Int.random(in: 0 ..< 100000000000000)
            guard let current = Auth.auth().currentUser, let imgData = item.pngData() else { return }
            let ref = fw.share.storage.child("products/\(current.uid)/\(randomIntFrom0To10).jpg")
            let _ = ref.putData(imgData, metadata: nil, completion: { (metaData, err) in
                ref.downloadURL(completion: { (url, err) in
                    guard let url = url?.absoluteString else { return }
                    count += 1
                    arrayStringImage.append(url)
                    if count == self.listImage.count {
                        completion(arrayStringImage)
                    }
                })
            })
        }
    }
    
//    private func setupNavigation() {
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        let btBack = UIButton(type: .system)
//        btBack.setTitle("Cancel", for: .normal)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btBack)
//        btBack.rx.tap.bind { _ in
//            self.dismiss(animated: true, completion: nil)
//        }.disposed(by: disposeBag)
//
//    }
    
    private func removeElementImage(indexPath: IndexPath) {
        self.listImage.remove(at: indexPath.row)
        self.collectionView.reloadData()
    }
}
extension PostProductVC: UICollectionViewDelegate {
}
extension PostProductVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.listImage.count < 3 {
            return self.listImage.count
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PostProductCell
        if isHasImage {
            cell.imgSelect.image = self.listImage[indexPath.row]
        }
        
        if indexPath.row == self.listImage.count - 1 {
            cell.btDelete.isHidden = true
        } else {
            cell.btDelete.isHidden = false
        }
        
        cell.buttonAction = { (sender) in
            self.removeElementImage(indexPath: indexPath)
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = self.showLoading()
        let img: UIImagePickerController = UIImagePickerController()
        self.isHasImage = true
        img.delegate = self
        img.allowsEditing = true
        img.sourceType = .photoLibrary
        self.indexPathSelect = indexPath
        alert.dismiss(animated: true) {
            self.present(img, animated: true, completion: nil)
        }
    }
    
}
extension PostProductVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 32) / 3 - 20
        return CGSize(width: width, height: self.collectionView.frame.size.height - 20)
    }
}
extension PostProductVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.dismiss(animated: true) {
            self.listImage.insert(image, at: 0)
            self.collectionView.reloadData()
        }
        
    }
}
extension PostProductVC: UINavigationControllerDelegate {
}
