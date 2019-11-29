//  File name   : TabbarInteractor.swift
//
//  Author      : MacbookPro
//  Created date: 11/23/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import RxSwift

protocol TabbarRouting: ViewableRouting {
    // todo: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TabbarPresentable: Presentable {
    var listener: TabbarPresentableListener? { get set }

    // todo: Declare methods the interactor can invoke the presenter to present data.
}

protocol TabbarListener: class {
    // todo: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class TabbarInteractor: PresentableInteractor<TabbarPresentable> {
    /// Class's public properties.
    weak var router: TabbarRouting?
    weak var listener: TabbarListener?

    /// Class's constructor.
    override init(presenter: TabbarPresentable) {
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

// MARK: TabbarInteractable's members
extension TabbarInteractor: TabbarInteractable {
}

// MARK: TabbarPresentableListener's members
extension TabbarInteractor: TabbarPresentableListener {
}

// MARK: Class's private methods
private extension TabbarInteractor {
    private func setupRX() {
        // todo: Bind data stream here.
    }
}
