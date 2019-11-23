//  File name   : RegisterEmailRouter.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

protocol RegisterEmailInteractable: Interactable, RegisterProfileListener {
    var router: RegisterEmailRouting? { get set }
    var listener: RegisterEmailListener? { get set }
}

protocol RegisterEmailViewControllable: ViewControllable {
    // todo: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class RegisterEmailRouter: ViewableRouter<RegisterEmailInteractable, RegisterEmailViewControllable> {
    /// Class's constructor.
    init(interactor: RegisterEmailInteractable,
                  viewController: RegisterEmailViewControllable,
                  registerProfikeBuildable: RegisterProfileBuildable) {
        self.registerProfikeBuildable = registerProfikeBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: Class's public methods
    override func didLoad() {
        super.didLoad()
    }
    private let registerProfikeBuildable: RegisterProfileBuildable
    private var registerProfile: ViewableRouting?
    /// Class's private properties.
}

// MARK: RegisterEmailRouting's members
extension RegisterEmailRouter: RegisterEmailRouting {
    func moveToRegisterProfile(email: String) {
        let registerProfile = registerProfikeBuildable.build(email: email)
        self.registerProfile = registerProfile
        attachChild(registerProfile)
        let navigation = UINavigationController(root: registerProfile.viewControllable)
        viewController.present(viewController: navigation)
    }
    
}

// MARK: Class's private methods
private extension RegisterEmailRouter {
}
