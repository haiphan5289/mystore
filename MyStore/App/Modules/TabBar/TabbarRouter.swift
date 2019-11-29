//  File name   : TabbarRouter.swift
//
//  Author      : MacbookPro
//  Created date: 11/23/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

protocol TabbarInteractable: Interactable {
    var router: TabbarRouting? { get set }
    var listener: TabbarListener? { get set }
}

protocol TabbarViewControllable: ViewControllable {
    // todo: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TabbarRouter: ViewableRouter<TabbarInteractable, TabbarViewControllable> {
    /// Class's constructor.
    override init(interactor: TabbarInteractable, viewController: TabbarViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: Class's public methods
    override func didLoad() {
        super.didLoad()
    }
    
    /// Class's private properties.
}

// MARK: TabbarRouting's members
extension TabbarRouter: TabbarRouting {
    
}

// MARK: Class's private methods
private extension TabbarRouter {

}
