//  File name   : RegisterProfileRouter.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

protocol RegisterProfileInteractable: Interactable {
    var router: RegisterProfileRouting? { get set }
    var listener: RegisterProfileListener? { get set }
}

protocol RegisterProfileViewControllable: ViewControllable {
    // todo: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RegisterProfileRouter: ViewableRouter<RegisterProfileInteractable, RegisterProfileViewControllable> {
    /// Class's constructor.
    override init(interactor: RegisterProfileInteractable, viewController: RegisterProfileViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: Class's public methods
    override func didLoad() {
        super.didLoad()
    }
    
    /// Class's private properties.
}

// MARK: RegisterProfileRouting's members
extension RegisterProfileRouter: RegisterProfileRouting {
    
}

// MARK: Class's private methods
private extension RegisterProfileRouter {
}
