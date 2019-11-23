//  File name   : RootRouter.swift
//
//  Author      : MacbookPro
//  Created date: 11/16/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

protocol RootInteractable: Interactable, LoginScreenListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // todo: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
    /// Class's constructor.
    init(interactor: RootInteractable, viewController: RootViewControllable,
                  loginScreenBuildable: LoginScreenBuildable) {
        self.loginScreenBuildable = loginScreenBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: Class's public methods
    override func didLoad() {
        super.didLoad()
        routeToLogin()
    }
    private let loginScreenBuildable: LoginScreenBuildable
    private var login: ViewableRouting?
    /// Class's private properties.
    func routeToLogin() {
        let rib = loginScreenBuildable.build()
        self.login = rib
        attachChild(rib)
        let navController = UINavigationController(root: rib.viewControllable)
        viewController.present(viewController: navController)
    }
}

// MARK: RootRouting's members
extension RootRouter: RootRouting {

    
}

// MARK: Class's private methods
private extension RootRouter {
}
extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController { return self }
    
    public convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}

