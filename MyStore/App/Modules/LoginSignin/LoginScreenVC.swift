//  File name   : LoginScreenVC.swift
//
//  Author      : MacbookPro
//  Created date: 11/16/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import RxSwift
import RxCocoa
import Firebase

protocol LoginScreenPresentableListener: class {
    // todo: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func routeToRegisterEmail()
    func routeToSignIn()
    func routeToTabbar()
}

final class LoginScreenVC: UIViewController, LoginScreenPresentable, LoginScreenViewControllable {
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    private struct Config {
    }
    
    /// Class's public properties.
    weak var listener: LoginScreenPresentableListener?
    @IBOutlet weak var lbPolicies: UILabel!
    @IBOutlet weak var btRegisterGmail: UIButton!
    @IBOutlet weak var btRegisterFacebook: UIButton!
    @IBOutlet weak var lbDesSlogan: UILabel!
    @IBOutlet weak var lbTextslogan: UILabel!
    @IBOutlet weak var lbAlreadyAccount: UILabel!
    @IBOutlet weak var btSignIn: UIButton!
    let fbLoginManager: LoginManager = LoginManager()
    private var disposeBag = DisposeBag()

    // MARK: View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        setupRX()
        isLogined()
//        isSignOut()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
        self.navigationController?.navigationBar.isHidden = true
    }
    /// Class's private properties.
}

// MARK: View's event handlers
extension LoginScreenVC {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: Class's public methods
extension LoginScreenVC {
}

// MARK: Class's private methods
private extension LoginScreenVC {
    private func localize() {
        // todo: Localize view's here.
        lbTextslogan.text = Text.slogan.localizedText
        lbDesSlogan.text = Text.desSlogan.localizedText
        lbAlreadyAccount.text = Text.alreadyAccount.localizedText
        lbPolicies.text = Text.desPolicies.localizedText
        btRegisterGmail.setTitle(Text.registerWithGmail.localizedText, for: .normal)
        btRegisterGmail.layer.cornerRadius = CGFloat(Constant.btRadiusLogin.value)
        btRegisterFacebook.setTitle(Text.registerWithFacebook.localizedText, for: .normal)
        btRegisterFacebook.layer.cornerRadius = CGFloat(Constant.btRadiusLogin.value)
        btSignIn.setTitle(Text.signIn.localizedText, for: .normal)
    }
    private func visualize() {
        // todo: Visualize view's here.
    }
    private func setupRX(){
        self.btRegisterFacebook.rx.tap.bind { _ in
            self.fbLoginManager.logIn(permissions: ["email"], from: self) { (result, err) in
                if err != nil {
                    print("\(String(describing: err))")
                    self.fbLoginManager.logOut()
                } else if result!.isCancelled {
                    self.fbLoginManager.logOut()
                } else {
                    //Setup để lấy dữ liệu khi load FB
                    let fbLoginManagerResult: LoginManagerLoginResult = result!
                    if fbLoginManagerResult.grantedPermissions != nil {
                        //                    let alert = FunctionAll.share.ShowLoadingWithAlert()
                        //                    self.present(alert, animated: true, completion: nil)
                        //                    truyền tham chiếu alert
                        self.getDataFacebook()
                    }
                }
            }
        }.disposed(by: disposeBag)
        
        self.btRegisterGmail.rx.tap.bind { _ in
            self.listener?.routeToRegisterEmail()
        }.disposed(by: disposeBag)
        
        self.btSignIn.rx.tap.bind { _ in
            self.listener?.routeToSignIn()
        }.disposed(by: disposeBag)
    }
    private func isLogined() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.listener?.routeToTabbar()
            }
        }
    }
    private func isSignOut(){
        do {
            try Auth.auth().signOut()
        } catch let err as Error {
            print(err.localizedDescription)
        }
        
    }
}
extension LoginScreenVC {
    func getDataFacebook(){
        //The method gets ìnformation from FB
        //Check AccessToken
        if AccessToken.current != nil {
            //the list parameters đê get data from FB
            let parameters = ["fields": "name, id, email"]
            GraphRequest(graphPath: "me", parameters: parameters).start { (connect, result, err) in
                if err != nil {
                    print("\(String(describing: err))")
                    return
                }
                do {
                    //convert Dic to Data để dẽ hứng dữ liệu
                    let jsonData = try JSONSerialization.data(withJSONObject: result!, options: .sortedKeys)
                    //parse JsonData with Decode
                    let jsonFB = try JSONDecoder().decode(User.self, from: jsonData)
                    //remove space string
                    //                        print( jsonFB.name!.replacingOccurrences(of: " ", with: ""))
                    //                    let profileUrl = "http://graph.facebook.com/\(jsonFB.id!)/picture?type=large"
                    //                    self.createUserOnFB(email: jsonFB.email!,
                    //                                        profileUrl: profileUrl,
                    //                                        pwd: jsonFB.id!,
                    //                                        name: jsonFB.name!,
                    //                                        alert: alert,
                    //                                        arUsers: arUsers )
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        else {
            //tắt popup khi đăng nhập FB không thành công
            //            alert.dismiss(animated: true, completion: nil)
            
        }
    }
}
