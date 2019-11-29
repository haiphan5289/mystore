//  File name   : LoginScreenRouter.swift
//
//  Author      : MacbookPro
//  Created date: 11/16/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

protocol LoginScreenInteractable: Interactable, RegisterEmailListener, SignInListener, TabbarListener {
    var router: LoginScreenRouting? { get set }
    var listener: LoginScreenListener? { get set }
}

protocol LoginScreenViewControllable: ViewControllable {
    // todo: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class LoginScreenRouter: ViewableRouter<LoginScreenInteractable, LoginScreenViewControllable> {
    /// Class's constructor.
    init(interactor: LoginScreenInteractable,
                  viewController: LoginScreenViewControllable,
                  registerEmailBuildable: RegisterEmailBuildable,
                  signInBuildable: SignInBuildable,
                  tabbarBuildable: TabbarBuildable) {
        self.tabbarBuildable = tabbarBuildable
        self.signInBuildable = signInBuildable
        self.registerEmailBuildable = registerEmailBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: Class's public methods
    override func didLoad() {
        super.didLoad()
    }
    private let registerEmailBuildable: RegisterEmailBuildable
    private var registerEmail: ViewableRouting?
    private var signInBuildable: SignInBuildable
    private let tabbarBuildable: TabbarBuildable
    
    /// Class's private properties.
}

// MARK: LoginScreenRouting's members
extension LoginScreenRouter: LoginScreenRouting {
    
    func routeToTabbar() {
        let route = tabbarBuildable.build(withListener: interactor)
        self.registerEmail = route
        attachChild(route)
        let navigation = UINavigationController(root: route.viewControllable)
        viewController.present(viewController: navigation)
    }
    
    func routeToRegisterEmail() {
        let registerEmail = registerEmailBuildable.build()
        self.registerEmail = registerEmail
        attachChild(registerEmail)
        let navigation = UINavigationController(root: registerEmail.viewControllable)
        viewController.present(viewController: navigation)
    }
    
    func routeToSignIn(){
        let signIn = signInBuildable.build(withListener: interactor)
        self.registerEmail = signIn
        attachChild(signIn)
        let navigation = UINavigationController(root: signIn.viewControllable)
        viewController.present(viewController: navigation)
        
    }
}

// MARK: Class's private methods
private extension LoginScreenRouter {
}
