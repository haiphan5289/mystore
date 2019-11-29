//  File name   : RegisterProfileVC.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import UIKit
import RxSwift
import RxCocoa
import Firebase

enum SelectImageFromLibrary {
    case photoLibrary
    case camera
}

protocol RegisterProfilePresentableListener: class {
    // todo: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    var emailObs: Observable<String> {get}
    func routeToTabbar()
}

final class RegisterProfileVC: UIViewController, RegisterProfilePresentable, RegisterProfileViewControllable {
    
    func present(viewController: ViewControllable) {
//        self.navigationController?.pushViewController(viewController.uiviewController, animated: true)
        self.present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    private struct Config {
    }
    
    /// Class's public properties.
    weak var listener: RegisterProfilePresentableListener?

    @IBOutlet weak var lbContentPictureProfile: UILabel!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var btRegister: UIButton!
    @IBOutlet weak var btSelectImage: UIButton!
    private var imageData: Data!
    private var isFirstName: Bool = false
    private var isLastName: Bool = false
    private var isPassword: Bool = false
    private let disposeBag = DisposeBag()
    let encoder = JSONEncoder()
    // MARK: View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        setupRX()
        imageData = UIImage(named: "camera")?.pngData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
        setupNavigation()
    }

    /// Class's private properties.
}

// MARK: View's event handlers
extension RegisterProfileVC {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: Class's public methods
extension RegisterProfileVC {
}

// MARK: Class's private methods
private extension RegisterProfileVC {
    private func localize() {
        // todo: Localize view's here.
        lbContentPictureProfile.text = Text.namePictureProfile.localizedText
        textFieldFirstName.placeholder = Text.firstName.localizedText
        textFieldLastName.placeholder = Text.lastName.localizedText
        textFieldPassword.placeholder = Text.password.localizedText
        btRegister.setTitle(Text.register.localizedText, for: .normal)
        btRegister.layer.cornerRadius = CGFloat(Constant.btRadiusLogin.value)
        btRegister.isEnabled = true
        btRegister.backgroundColor = CustomColor.grey.getColor()
        btRegister.layer.cornerRadius = CGFloat(Constant.btRadiusLogin.value)
    }
    private func visualize() {
        // todo: Visualize view's here.
    }
    private func setupRX() {
//        textFieldFirstName.rx.text.orEmpty.bind { [weak self] (text) in
//            self?.isFirstName = (text.count > 0) ? true : false
//            self?.validShowButtonRegister()
//        }.disposed(by: disposeBag)
        //        textFieldLastName.rx.text.orEmpty.bind { [weak self] (text) in
        //            self?.isLastName = (text.count > 0) ? true : false
        //            self?.validShowButtonRegister()
        //            }.disposed(by: disposeBag)
        //
        //        textFieldPassword.rx.text.orEmpty.bind { [weak self] (text) in
        //            self?.isPassword = (text.count > 0) ? true : false
        //            self?.validShowButtonRegister()
        //            }.disposed(by: disposeBag)
        let isFirstName = textFieldFirstName.rx.text.orEmpty.map { (s1) -> Bool in
            return s1.count > 0
        }
        let isLastName = textFieldLastName.rx.text.orEmpty.map { (s1) -> Bool in
            return s1.count > 0
        }
        let isPassword = textFieldPassword.rx.text.orEmpty.map { (s1) -> Bool in
            return s1.count >= 6
        }
        
        let isButtonRegisterEnable = Observable.combineLatest(isFirstName, isLastName, isPassword) { (s1, s2, s3) in
            return s1 && s2 && s3
        }
        isButtonRegisterEnable.bind { [weak self] enable in
            guard let me = self else { return}
            if enable {
                me.btRegister.isEnabled = true
                me.btRegister.backgroundColor = CustomColor.green.getColor()
            } else {
                me.btRegister.isEnabled = true
                me.btRegister.backgroundColor = CustomColor.grey.getColor()
            }
        }.disposed(by: disposeBag)
        

        
        btRegister.rx.tap.bind { _ in
            let alert = self.showLoading()
            guard let password = self.textFieldPassword.text,
                let firstName = self.textFieldFirstName.text,
                let lastName = self.textFieldLastName.text else { return }
            self.listener?.emailObs.asObservable().subscribe(onNext: { (email) in
                Auth.auth().createUser(withEmail: email, password: password, completion: { (data, err) in
                    if let err = err {
                        print(err.localizedDescription)
                    } else {
                        let current = Auth.auth().currentUser
                        let ref = fw.share.storage.child("imagesProfiles/\(email).jpg")
                        let _ = ref.putData(self.imageData, metadata: nil) { (metadata, error) in
                            ref.downloadURL { (url, error) in
                                guard let downloadURL = url?.absoluteString else {
                                    return
                                }
                                let tableUser = fw.share.dataBase.child("Users").child(current!.uid)
                                let infoUser: Dictionary<String,Any> = ["id": current?.uid,
                                                                        "email": email,
                                                                        "firstName": firstName,
                                                                        "lastName": lastName,
                                                                        "urlProfile": downloadURL,
                                                                        "password": password]
                                tableUser.setValue(infoUser)
                                alert.dismiss(animated: true, completion: {
                                    self.listener?.routeToTabbar()
                                })
        
                            }
                        }
                    }
                })
                // Create a reference to the file you want to upload
//                alert.dismiss(animated: true, completion: nil)
            }).disposed(by: self.disposeBag)
            }.disposed(by: disposeBag)
        
        btSelectImage.rx.tap.bind { _ in
            let alert: UIAlertController = UIAlertController(title: "Thông báo",
                                                             message: "Bạn muốn chọn hình từ",
                                                             preferredStyle: .alert)
            let btCamera: UIAlertAction = UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.checkCaseSelectImage(type: .camera)
            })
            let btPhoto: UIAlertAction = UIAlertAction(title: "Photos", style: .default, handler: { _ in
                self.checkCaseSelectImage(type: .photoLibrary)
            })
            let btCancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(btCamera)
            alert.addAction(btPhoto)
            alert.addAction(btCancel)
            self.present(alert, animated: true, completion: nil)
        }.disposed(by: disposeBag)

        
    }
    private func checkCaseSelectImage(type: SelectImageFromLibrary){
        let imag = UIImagePickerController()
        imag.delegate = self
        imag.allowsEditing = true
        switch type {
        case .camera:
            imag.sourceType = .camera
        default:
            imag.sourceType = .photoLibrary
        }
        self.present(imag, animated: true, completion: nil)
    }
    private func setupNavigation() {
        self.navigationItem.title = Text.register.localizedText
        let btLeft: UIButton = UIButton(type: .system)
        btLeft.setTitle(Text.cancel.localizedText, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btLeft)
        btLeft.rx.tap.bind { _ in
            self.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    private func validShowButtonRegister() {
        if isLastName && isFirstName && isPassword {
            btRegister.isEnabled = true
            btRegister.backgroundColor = CustomColor.green.getColor()
        } else {
            btRegister.isEnabled = true
            btRegister.backgroundColor = CustomColor.grey.getColor()
        }
    }
}
extension RegisterProfileVC: UIImagePickerControllerDelegate {
    
}
extension RegisterProfileVC: UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        picker.dismiss(animated: true) {
            self.btSelectImage.setImage(image, for: .normal)
            self.imageData = image.pngData()
        }
    }
}
