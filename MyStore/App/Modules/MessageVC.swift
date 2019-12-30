//
//  MessageVC.swift
//  MyStore
//
//  Created by MacbookPro on 12/20/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit
import Firebase
import RxSwift

enum SendMessType {
    case text
    case video
    case image
}

class MessageVC: UIViewController {

    @IBOutlet weak var btGallery: UIButton!
    @IBOutlet weak var btSend: UIButton!
    @IBOutlet weak var tfText: UITextField!
    @IBOutlet weak var viewSendMessage: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgShow: UIImageView!
    @IBOutlet weak var heightViewSendMess: NSLayoutConstraint!
    @IBOutlet weak var btDeleteImage: UIButton!
    private var userAdmin: UserFireBase!
    private let disposeBag = DisposeBag()
    private var imageData: Data!
    private var typeSend: SendMessType = .text
    private var dataSource: [MessFireBase] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MessageCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        getProfileAdmin()
        setupRX()
        setupNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        visualize()
        self.getMessageFromFirebase()
    }
    
    private func setupRX() {
        btSend.rx.tap.bind { _ in
            guard let current = Auth.auth().currentUser else { return }
            var dataString: String = ""
            switch self.typeSend {
            case .image:
                print("hihi")
            case .video:
                self.sendImageToFirebase()
            default:
                dataString = self.getTextToSendFireabase()
            }

            let time: NSNumber = NSNumber(value: Date().timeIntervalSince1970)
            let dic: [String: Any] = ["mess": dataString, "fromID": current.uid, "toID": self.userAdmin.id, "time": time]
            let tableMess = fw.share.dataBase.child("Mess").childByAutoId()
            tableMess.setValue(dic, withCompletionBlock: { (err, data) in
                if err != nil {
                    self.showAlertError(errStr: err?.localizedDescription ?? "")
                } else {
                    let tableUserMessFrom = fw.share.dataBase.child("User-Mess").child(current.uid).child(self.userAdmin.id ?? "")
                    let dic: [String: Any] = ["\(data.key!)": "1"]
                    tableUserMessFrom.updateChildValues(dic)
                    let tableUserTo = fw.share.dataBase.child("User-Mess").child(self.userAdmin.id ?? "").child(current.uid)
                    tableUserTo.updateChildValues(dic)
                    self.tfText.text = nil
                }
            })
            
            }.disposed(by: disposeBag)
        
        tfText.rx.text.subscribe(onNext: { value in
            if let count = value?.count {
                self.btSend.isEnabled = (count > 0) ? true : false
            }
        }).disposed(by: disposeBag)
        
        btGallery.rx.tap.bind { _ in
            let imagePickerController: UIImagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
        btDeleteImage.rx.tap.bind { _ in
            self.imgShow.image = nil
            self.heightViewSendMess.constant = 50
            self.imageData = nil
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
                self.imgShow.isHidden = true
                self.btDeleteImage.isHidden = true
            })
        }.disposed(by: disposeBag)
    }
    
    private func setupNavigation() {
//        self.navigationItem.title = Text.message.localizedText
        self.title = Text.message.localizedText
    }
    
    private func visualize() {
        tfText.placeholder = Text.typingMessage.localizedText
        viewSendMessage.layer.borderColor = CustomColor.greyLine.getColor().cgColor
        viewSendMessage.layer.borderWidth = CGFloat(Constant.radiusTextField.value)
        heightViewSendMess.constant = 50
        self.imgShow.isHidden = true
        self.btDeleteImage.isHidden = true
        
    }
    
    private func getMessageFromFirebase() {
        if let current =  Auth.auth().currentUser?.uid {
            let tableUserMess = fw.share.dataBase.child("User-Mess").child(current)
            tableUserMess.observe(.childAdded) { (data) in
                let key = data.key
                let tabelPartner = fw.share.dataBase.child("User-Mess").child(current).child(key)
                tabelPartner.observe(.childAdded, with: { (data) in
                    let keyMess = data.key
                    let tableMess = fw.share.dataBase.child("Mess").child(keyMess)
                    tableMess.observe(.value, with: { (data) in
                        let mess: MessFireBase = MessFireBase(snapshot: data)
                        self.dataSource.append(mess)
                        self.collectionView.reloadData()
                    })
                })
            }
        }
    }
    
    private func sendImageToFirebase() {
        
    }

    private func getTextToSendFireabase() -> String {
        if let mess = self.tfText.text {
            return mess
        }
        return ""
    }
    
    private func getProfileAdmin() {
        let tableUserAdmin = fw.share.dataBase.child("Users").child("1Vaq2rOSrNh9szwAYL6GuULKqIm1")
        tableUserAdmin.observe(.value) { (data) in
            self.userAdmin = UserFireBase(snapshot: data)
        }
    }
    
    private func estimateText(text: String) -> CGRect {
        let size = CGSize(width: UIScreen.main.bounds.width - 150, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                     options: option,
                                                     attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)],
                                                     context: nil)
    }
}

extension MessageVC: UICollectionViewDelegate {
}
extension MessageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //get height text
        let item = self.dataSource[indexPath.row]
        let height = estimateText(text: item.mess ?? "").height + 20
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: height)
    }
}
extension MessageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MessageCell
        let item = self.dataSource[indexPath.row]
        cell.tvMessage.text = item.mess
        if let currentUser = Auth.auth().currentUser {
            if currentUser.uid == item.fromID {
                cell.backgroundColor = .brown
            } else {
                cell.backgroundColor = .red
            }
        }
        return cell
        
    }
    
}
extension MessageVC: UIImagePickerControllerDelegate {
}
extension MessageVC: UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        picker.dismiss(animated: true) {
            self.imageData = image.pngData()
            self.typeSend = .image
            self.imgShow.image = image
            self.heightViewSendMess.constant = 100
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
                self.imgShow.isHidden = false
                self.btDeleteImage.isHidden = false
            })
        }
    }
}
