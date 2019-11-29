//  File name   : SignInVC.swift
//
//  Author      : MacbookPro
//  Created date: 11/26/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import UIKit
import RxCocoa
import RxSwift
import Firebase

protocol SignInPresentableListener: class {
    // todo: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func routeToTabBar()
}

final class SignInVC: UIViewController, SignInPresentable, SignInViewControllable {
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    private struct Config {
    }
    
    /// Class's public properties.
    weak var listener: SignInPresentableListener?
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbForgotPassword: UILabel!
    @IBOutlet weak var btSignIn: UIButton!
    private let disposeBag = DisposeBag()
    private let maxLeghtPassword = 6
    
    // MARK: View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        setupRX()
        setupNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
    }

    /// Class's private properties.
}

// MARK: View's event handlers
extension SignInVC {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: Class's public methods
extension SignInVC {
}

// MARK: Class's private methods
private extension SignInVC {
    private func localize() {
        // todo: Localize view's here.
        tfEmail.placeholder = Text.email.localizedText
        tfPassword.placeholder = Text.password.localizedText
        lbForgotPassword.text = Text.forgotYourPassword.localizedText
        btSignIn.setTitle(Text.signIn.localizedText, for: .normal)
        btSignIn.layer.cornerRadius = CGFloat(Constant.btRadiusLogin.value)
        btSignIn.isEnabled = false
    }
    private func visualize() {
        // todo: Visualize view's here.
    }
    private func setupRX(){
        heighKeyBoard().asObservable().subscribe(onNext: { (value) in
            self.btSignIn.transform = CGAffineTransform(translationX: 0, y: -value)
        }).disposed(by: disposeBag)
        
        let isEmail = tfEmail.rx.text.orEmpty.map { value -> Bool in
            return fw.share.isValidEmail(emailStr: value)
            }
        let isPassword = tfPassword.rx.text.orEmpty.map { value -> Bool in
            return value.count >= self.maxLeghtPassword
        }
        
        let isButtonSignIn = Observable.combineLatest(isEmail, isPassword).map { (isEmailCheck, isPasswordCheck) -> Bool in
            self.tfEmail.textColor = (isEmailCheck) ? CustomColor.grey.getColor() : CustomColor.orage.getColor()
            return (isEmailCheck && isPasswordCheck) ? true : false
        }
        
        isButtonSignIn.bind { (enable) in
            if enable {
                self.btSignIn.isEnabled = true
                self.btSignIn.setTitleColor(CustomColor.green.getColor(), for: .normal)
            } else {
                self.btSignIn.isEnabled = true
                self.btSignIn.setTitleColor(CustomColor.white.getColor(), for: .normal)
            }
            
        }.disposed(by: disposeBag)
        
        self.btSignIn.rx.tap.bind { _ in
            let alert = self.showLoading()
            guard let email = self.tfEmail.text, let password = self.tfPassword.text else { return }
            Auth.auth().signIn(withEmail: email, password: password, completion: { (auth, err) in
                if let err = err {
                    if !err.localizedDescription.isEmpty {
                        alert.dismiss(animated: true, completion: {
                            self.showAlertError(errStr: err.localizedDescription)
                        })
                    }
                } else {
                    alert.dismiss(animated: true, completion: {
                        self.listener?.routeToTabBar()
                    })
                }
            })
        }.disposed(by: disposeBag)
        
    }
    private func heighKeyBoard() -> Observable<CGFloat> {
        return Observable.from([
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).map({ (notification) -> CGFloat in
                 (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }),
            NotificationCenter.default.rx.notification(UIResponder.keyboardDidHideNotification).map({ _ -> CGFloat in
                0
            })
            ])
        .merge()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = Text.signIn.localizedText
        let btLeft: UIButton = UIButton(type: .system)
        btLeft.setTitle(Text.cancel.localizedText, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btLeft)
        btLeft.rx.tap.bind { _ in
            self.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
}
