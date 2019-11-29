//  File name   : SignInBuilder.swift
//
//  Author      : MacbookPro
//  Created date: 11/26/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

// MARK: Dependency tree
protocol SignInDependency: Dependency {
    // todo: Declare the set of dependencies required by this RIB, but cannot be created by this RIB.
}

final class SignInComponent: Component<SignInDependency> {
    /// Class's public properties.
    let SignInVC: SignInVC
    
    /// Class's constructor.
    init(dependency: SignInDependency, SignInVC: SignInVC) {
        self.SignInVC = SignInVC
        super.init(dependency: dependency)
    }
    
    /// Class's private properties.
    // todo: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: Builder
protocol SignInBuildable: Buildable {
    func build(withListener listener: SignInListener) -> SignInRouting
}

final class SignInBuilder: Builder<SignInDependency>, SignInBuildable {
    /// Class's constructor.
    override init(dependency: SignInDependency) {
        super.init(dependency: dependency)
    }
    
    // MARK: SignInBuildable's members
    func build(withListener listener: SignInListener) -> SignInRouting {
        let vc = UIStoryboard.init(name: "LoginStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        let component = SignInComponent(dependency: dependency, SignInVC: vc)

        let interactor = SignInInteractor(presenter: component.SignInVC)
        interactor.listener = listener
        let tabbarBuilder = TabbarBuilder(dependency: component)

        // todo: Create builder modules builders and inject into router here.
        
        return SignInRouter(interactor: interactor,
                            viewController: component.SignInVC,
                            tabbatBuildable: tabbarBuilder)
    }
}
