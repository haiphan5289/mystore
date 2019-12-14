//  File name   : PostProductInteractor.swift
//
//  Author      : MacbookPro
//  Created date: 11/29/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import RxSwift

protocol PostProductRouting: ViewableRouting {
    // todo: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol PostProductPresentable: Presentable {
    var listener: PostProductPresentableListener? { get set }

    // todo: Declare methods the interactor can invoke the presenter to present data.
}

protocol PostProductListener: class {
    // todo: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class PostProductInteractor: PresentableInteractor<PostProductPresentable> {
    /// Class's public properties.
    weak var router: PostProductRouting?
    weak var listener: PostProductListener?

    /// Class's constructor.
    override init(presenter: PostProductPresentable) {
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

// MARK: PostProductInteractable's members
extension PostProductInteractor: PostProductInteractable {
}

// MARK: PostProductPresentableListener's members
extension PostProductInteractor: PostProductPresentableListener {
}

// MARK: Class's private methods
private extension PostProductInteractor {
    private func setupRX() {
        // todo: Bind data stream here.
    }
}
