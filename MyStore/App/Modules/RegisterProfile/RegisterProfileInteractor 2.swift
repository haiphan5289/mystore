//  File name   : RegisterProfileInteractor.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import RxSwift

protocol RegisterProfileRouting: ViewableRouting {
    // todo: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToTabbar()
}

protocol RegisterProfilePresentable: Presentable {
    var listener: RegisterProfilePresentableListener? { get set }

    // todo: Declare methods the interactor can invoke the presenter to present data.
}

protocol RegisterProfileListener: class {
    // todo: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RegisterProfileInteractor: PresentableInteractor<RegisterProfilePresentable> {
    /// Class's public properties.
    weak var router: RegisterProfileRouting?
    weak var listener: RegisterProfileListener?
    private let email: String
    private var emailSubject: Variable<String> = Variable("")
    /// Class's constructor.
    init(presenter: RegisterProfilePresentable, email: String) {
        self.email = email
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

// MARK: RegisterProfileInteractable's members
extension RegisterProfileInteractor: RegisterProfileInteractable {
}

// MARK: RegisterProfilePresentableListener's members
extension RegisterProfileInteractor: RegisterProfilePresentableListener {
    func routeToTabbar() {
        router?.routeToTabbar()
    }
    
    
    var emailObs: Observable<String> {
        return self.emailSubject.asObservable()
    }
    
    
}

// MARK: Class's private methods
private extension RegisterProfileInteractor {
    private func setupRX() {
        // todo: Bind data stream here.
        self.emailSubject.value = email
    }
}
