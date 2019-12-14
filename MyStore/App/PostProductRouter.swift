//  File name   : PostProductRouter.swift
//
//  Author      : MacbookPro
//  Created date: 11/29/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

protocol PostProductInteractable: Interactable {
    var router: PostProductRouting? { get set }
    var listener: PostProductListener? { get set }
}

protocol PostProductViewControllable: ViewControllable {
    // todo: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PostProductRouter: ViewableRouter<PostProductInteractable, PostProductViewControllable> {
    /// Class's constructor.
    override init(interactor: PostProductInteractable, viewController: PostProductViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: Class's public methods
    override func didLoad() {
        super.didLoad()
    }
    
    /// Class's private properties.
}

// MARK: PostProductRouting's members
extension PostProductRouter: PostProductRouting {
    
}

// MARK: Class's private methods
private extension PostProductRouter {
}
