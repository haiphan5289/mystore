//  File name   : RegisterProfileRouter.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

protocol RegisterProfileInteractable: Interactable, TabbarListener {
    var router: RegisterProfileRouting? { get set }
    var listener: RegisterProfileListener? { get set }
}

protocol RegisterProfileViewControllable: ViewControllable {
    // todo: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class RegisterProfileRouter: ViewableRouter<RegisterProfileInteractable, RegisterProfileViewControllable> {
    /// Class's constructor.
    init(interactor: RegisterProfileInteractable, viewController: RegisterProfileViewControllable, tabbarBuildable: TabbarBuildable) {
        self.tabbarBuildable = tabbarBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: Class's public methods
    override func didLoad() {
        super.didLoad()
    }
    
    /// Class's private properties.
    private var tabbarBuildable: TabbarBuildable
    private var tabbarRoutting: ViewableRouting?
}

// MARK: RegisterProfileRouting's members
extension RegisterProfileRouter: RegisterProfileRouting {
    func routeToTabbar() {
        let tabbarRoutting = tabbarBuildable.build(withListener: interactor)
        self.tabbarRoutting = tabbarRoutting
        attachChild(tabbarRoutting)
        let navi = UINavigationController(root: tabbarRoutting.viewControllable)
        viewController.present(viewController: navi)
//        let registerProfile = registerProfikeBuildable.build(email: email)
//        self.registerProfile = registerProfile
//        attachChild(registerProfile)
//        let navigation = UINavigationController(root: registerProfile.viewControllable)
//        viewController.present(viewController: navigation)
    }
    
}

// MARK: Class's private methods
private extension RegisterProfileRouter {
}
