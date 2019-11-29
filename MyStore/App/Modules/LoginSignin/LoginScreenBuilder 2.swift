//  File name   : LoginScreenBuilder.swift
//
//  Author      : MacbookPro
//  Created date: 11/16/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

// MARK: Dependency tree
protocol LoginScreenDependency: Dependency {
    // todo: Declare the set of dependencies required by this RIB, but cannot be created by this RIB.
}

final class LoginScreenComponent: Component<LoginScreenDependency> {
    /// Class's public properties.
    let LoginScreenVC: LoginScreenVC
    
    /// Class's constructor.
    init(dependency: LoginScreenDependency, LoginScreenVC: LoginScreenVC) {
        self.LoginScreenVC = LoginScreenVC
        super.init(dependency: dependency)
    }
    
    /// Class's private properties.
    // todo: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: Builder
protocol LoginScreenBuildable: Buildable {
    func build() -> LoginScreenRouting
}

final class LoginScreenBuilder: Builder<LoginScreenDependency>, LoginScreenBuildable {
    /// Class's constructor.
    override init(dependency: LoginScreenDependency) {
        super.init(dependency: dependency)
    }
    
    // MARK: LoginScreenBuildable's members
    func build() -> LoginScreenRouting {
//        let vc = LoginScreenVC()
        let vc = UIStoryboard.init(name: "LoginStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginScreenVC
        let component = LoginScreenComponent(dependency: dependency, LoginScreenVC: vc)

        let interactor = LoginScreenInteractor(presenter: component.LoginScreenVC)
//        interactor.listener = listener
        let registerEmailBuilder = RegisterEmailBuilder(dependency: component)

        // todo: Create builder modules builders and inject into router here.
        
        return LoginScreenRouter(interactor: interactor,
                                 viewController: component.LoginScreenVC,
                                 registerEmailBuildable: registerEmailBuilder)
    }
}
