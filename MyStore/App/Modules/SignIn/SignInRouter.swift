//  File name   : SignInRouter.swift
//
//  Author      : MacbookPro
//  Created date: 11/26/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

protocol SignInInteractable: Interactable, TabbarListener {
    var router: SignInRouting? { get set }
    var listener: SignInListener? { get set }
}

protocol SignInViewControllable: ViewControllable {
    // todo: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class SignInRouter: ViewableRouter<SignInInteractable, SignInViewControllable> {
    /// Class's constructor.
    init(interactor: SignInInteractable,
                  viewController: SignInViewControllable,
                  tabbatBuildable: TabbarBuildable) {
        self.tabbatBuildable = tabbatBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: Class's public methods
    override func didLoad() {
        super.didLoad()
    }
    
    /// Class's private properties.
    private let tabbatBuildable: TabbarBuildable
    private var tabbarRouting: ViewableRouting?
}

// MARK: SignInRouting's members
extension SignInRouter: SignInRouting {
    func routeToTabBar() {
        let tabbar = tabbatBuildable.build(withListener: interactor)
        self.tabbarRouting = tabbar
        attachChild(tabbar)
        let navigation = UINavigationController(root: tabbar.viewControllable)
        viewController.present(viewController: navigation)
        
    }
    
}

// MARK: Class's private methods
private extension SignInRouter {
}
