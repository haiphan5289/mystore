//  File name   : SignInInteractor.swift
//
//  Author      : MacbookPro
//  Created date: 11/26/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import RxSwift

protocol SignInRouting: ViewableRouting {
    // todo: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToTabBar()
}

protocol SignInPresentable: Presentable {
    var listener: SignInPresentableListener? { get set }

    // todo: Declare methods the interactor can invoke the presenter to present data.
}

protocol SignInListener: class {
    // todo: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SignInInteractor: PresentableInteractor<SignInPresentable> {
    /// Class's public properties.
    weak var router: SignInRouting?
    weak var listener: SignInListener?

    /// Class's constructor.
    override init(presenter: SignInPresentable) {
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

// MARK: SignInInteractable's members
extension SignInInteractor: SignInInteractable {
}

// MARK: SignInPresentableListener's members
extension SignInInteractor: SignInPresentableListener {
    func routeToTabBar() {
        router?.routeToTabBar()
    }
}

// MARK: Class's private methods
private extension SignInInteractor {
    private func setupRX() {
        // todo: Bind data stream here.
    }
}
