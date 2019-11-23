//  File name   : LoginScreenInteractor.swift
//
//  Author      : MacbookPro
//  Created date: 11/16/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import RxSwift

protocol LoginScreenRouting: ViewableRouting {
    // todo: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToRegisterEmail()
}

protocol LoginScreenPresentable: Presentable {
    var listener: LoginScreenPresentableListener? { get set }

    // todo: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoginScreenListener: class {
    // todo: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoginScreenInteractor: PresentableInteractor<LoginScreenPresentable> {
    /// Class's public properties.
    weak var router: LoginScreenRouting?
    weak var listener: LoginScreenListener?

    /// Class's constructor.
    override init(presenter: LoginScreenPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: Class's public methods
    override func didBecomeActive() {
        super.didBecomeActive()
        setupRX()
        
        // todo: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // todo: Pause any business logic.
    }

    /// Class's private properties.
}

// MARK: LoginScreenInteractable's members
extension LoginScreenInteractor: LoginScreenInteractable {
}

// MARK: LoginScreenPresentableListener's members
extension LoginScreenInteractor: LoginScreenPresentableListener {
    func routeToRegisterEmail(){
        router?.routeToRegisterEmail()
    }
}

// MARK: Class's private methods
private extension LoginScreenInteractor {
    private func setupRX() {
        // todo: Bind data stream here.
    }
}
