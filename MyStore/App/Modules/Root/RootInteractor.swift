//  File name   : RootInteractor.swift
//
//  Author      : MacbookPro
//  Created date: 11/16/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    // todo: Declare methods the interactor can invoke to manage sub-tree via the router.
//    func routeToLogin()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }

    // todo: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // todo: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable> {
    /// Class's public properties.
    weak var router: RootRouting?
    weak var listener: RootListener?

    /// Class's constructor.
    override init(presenter: RootPresentable) {
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

// MARK: RootInteractable's members
extension RootInteractor: RootInteractable {
}

// MARK: RootPresentableListener's members
extension RootInteractor: RootPresentableListener {
//    func routeToLogin(){
//        router?.routeToLogin()
//    }
}

// MARK: Class's private methods
private extension RootInteractor {
    private func setupRX() {
        // todo: Bind data stream here.
    }
}
