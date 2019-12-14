//
//  ProfileViewController.swift
//  MyStore
//
//  Created by MacbookPro on 11/26/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase
import Kingfisher
import RIBs

class ProfileViewController: UIViewController, PostProductListener {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var lbFirstName: UILabel!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var lbLastName: UILabel!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var btChangePassword: UIButton!
    @IBOutlet weak var btSignOut: UIButton!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var btPostProduct: UIButton!
    private let disposeBag = DisposeBag()
    private var routePostProduct: PostProductRouting?
    private var postProductBuildable: PostProductBuildable?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRX()
    }
    override func viewWillAppear(_ animated: Bool) {
        localize()
    }
    private func localize() {
        lbEmail.text = Text.email.localizedText
        lbFirstName.text = Text.firstName.localizedText
        lbLastName.text = Text.lastName.localizedText
        btSignOut.setTitle(Text.signOut.localizedText, for: .normal)
        btSignOut.layer.cornerRadius = CGFloat(Constant.btRadiusLogin.value)
        btChangePassword.setTitle(Text.changePassword.localizedText, for: .normal)
        btChangePassword.layer.cornerRadius = CGFloat(Constant.btRadiusLogin.value)
        btPostProduct.setTitle(Text.postProduct.localizedText, for: .normal)
        btPostProduct.layer.cornerRadius = CGFloat(Constant.btRadiusLogin.value)
        
        tfEmail.text = Profile.share.email
        tfFirstName.text = Profile.share.firstName
        tfLastName.text = Profile.share.lastName
        if let url = Profile.share.urlProfile {
            self.imgProfile.kf.setImage(with: URL(string: url))
        }
        
    }
    private func setupRX() {
//        heightKeyboard().asObservable().bind { (height) in
//            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
//            self.btSignOut.transform = CGAffineTransform(translationX: 0, y: -height + 57)
//            var rect = self.viewFirstName.convert(self.viewFirstName.frame, from: self.scrollView)
//            rect.size.height -= 60
//            self.scrollView.scrollRectToVisible(rect, animated: true)
//        }.disposed(by: disposeBag)
        tapGesture.rx.event.subscribe(onNext: { _ in
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
        fetchProfile { (data) in
           return data
        }
        
        btPostProduct.rx.tap.bind { _ in
            self.postProductBuildable = PostProductBuilder(dependency: ProfileComponent())
            self.routePostProduct = self.postProductBuildable?.build(withListener: self)
            self.routePostProduct?.interactable.activate()
            self.routePostProduct?.load()
            self.navigationController?.pushViewController((self.routePostProduct?.viewControllable.uiviewController)!, animated: true)
        }.disposed(by: disposeBag)
        
        btSignOut.rx.tap.bind { _ in
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            }catch let err as NSError {
                self.showAlertError(errStr: err.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    private func fetchProfile( completion: @escaping (DataSnapshot) -> DataSnapshot){
        if let current = Auth.auth().currentUser {
            let tableUser = fw.share.dataBase.child("Users").child(current.uid)
            tableUser.observe(.value, with: { (data) in
                completion(data)
            }) { (err) in
                self.showAlertError(errStr: err.localizedDescription)
            }
        }
    }

    private func heightKeyboard() -> Observable<CGFloat> {
        return Observable.from([
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).map({ (notification) -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }),
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification).map({ _  in
                0
            })
            ])
            .merge()
    }
}

protocol ProfileDependency: Dependency {
    // todo: Declare the set of dependencies required by this RIB, but cannot be created by this RIB.
}

final class ProfileComponent: Component<EmptyComponent>, ProfileDependency {
    /// Class's public properties.
//    let profileVC: ProfileViewController
    
    /// Class's constructor.
    init() {
        super.init(dependency: EmptyComponent())
    }
    
    /// Class's private properties.
    // todo: Declare 'fileprivate' dependencies that are only used by this RIB.
}
//protocol UpdatePlaceDependency: Dependency {
//    var authenticated: AuthenticatedStream { get }
//}
//final class UpdatePlaceComponent: Component<EmptyComponent>, UpdatePlaceDependency {
//    var authenticated: AuthenticatedStream
//
//    init(authenticate: AuthenticatedStream) {
//        self.authenticated = authenticate
//        super.init(dependency: EmptyComponent())
//    }
//}
