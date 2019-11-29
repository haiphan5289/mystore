//  File name   : RegisterEmailInteractor.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import RxSwift

protocol RegisterEmailRouting: ViewableRouting {
    // todo: Declare methods the interactor can invoke to manage sub-tree via the router.
    func moveToRegisterProfile(email: String)
}

protocol RegisterEmailPresentable: Presentable {
    var listener: RegisterEmailPresentableListener? { get set }

    // todo: Declare methods the interactor can invoke the presenter to present data.
}

protocol RegisterEmailListener: class {
    // todo: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RegisterEmailInteractor: PresentableInteractor<RegisterEmailPresentable> {
    /// Class's public properties.
    weak var router: RegisterEmailRouting?
    weak var listener: RegisterEmailListener?

    /// Class's constructor.
    override init(presenter: RegisterEmailPresentable) {
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

// MARK: RegisterEmailInteractable's members
extension RegisterEmailInteractor: RegisterEmailInteractable {
}

// MARK: RegisterEmailPresentableListener's members
extension RegisterEmailInteractor: RegisterEmailPresentableListener {
    func moveToProfile(email: String) {
        router?.moveToRegisterProfile(email: email)
    }
}

// MARK: Class's private methods
private extension RegisterEmailInteractor {
    private func setupRX() {
        // todo: Bind data stream here.
    }
}
