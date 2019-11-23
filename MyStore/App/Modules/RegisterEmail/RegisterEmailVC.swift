//  File name   : RegisterEmailVC.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import UIKit
import RxCocoa
import RxSwift

protocol RegisterEmailPresentableListener: class {
    // todo: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func moveToProfile(email: String)
}

final class RegisterEmailVC: UIViewController, RegisterEmailPresentable, RegisterEmailViewControllable {
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    private struct Config {
    }
    
    /// Class's public properties.
    weak var listener: RegisterEmailPresentableListener?
    @IBOutlet weak var lbYourEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btNext: UIButton!
    private lazy var disposeBag = DisposeBag()
    private lazy var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()

    // MARK: View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        setupRX()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
        setupNavigation()
    }

    /// Class's private properties.
}

// MARK: View's event handlers
extension RegisterEmailVC {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: Class's public methods
extension RegisterEmailVC {
}

// MARK: Class's private methods
private extension RegisterEmailVC {
    private func localize() {
        // todo: Localize view's here.
        lbYourEmail.text = Text.yourEmail.localizedText
        btNext.setTitle(Text.next.localizedText, for: .normal)
        btNext.layer.cornerRadius = 20
    }
    private func visualize() {
        // todo: Visualize view's here.
        self.btNext.isEnabled = false
        self.btNext.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
    }
    private func setupNavigation(){
        self.navigationItem.title = Text.register.localizedText
        let btLeft: UIButton = UIButton(type: .system)
        btLeft.setTitle(Text.cancel.localizedText, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btLeft)
        btLeft.rx.tap.bind { _ in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    private func setupRX(){
        keyboardHeight().asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (value) in
                //Cách 1 đổi position của btNext
                self.btNext.transform = CGAffineTransform(translationX: 0, y: -value)
            })
            .disposed(by: disposeBag)
        
        tapGesture.rx.event.bind { _ in
            self.view.endEditing(true)
            }.disposed(by: disposeBag)
        
        tfEmail.rx.text.orEmpty.subscribe(onNext: { (value) in
            if fw.share.isValidEmail(emailStr: value) {
                self.btNext.isEnabled = true
                self.btNext.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            } else {
                self.btNext.isEnabled = false
                self.btNext.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            }
        }).disposed(by: disposeBag)
        
        btNext.rx.tap.bind { _ in
            guard let email = self.tfEmail.text else { return }
            self.listener?.moveToProfile(email: email)
        }.disposed(by: disposeBag)
        
    }
    private func keyboardHeight() -> Observable<CGFloat> {
        return Observable.from([
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).map({ (notification) -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }),
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification).map({ _ -> CGFloat in
                0
            })])
            .merge()
        
    }
}
