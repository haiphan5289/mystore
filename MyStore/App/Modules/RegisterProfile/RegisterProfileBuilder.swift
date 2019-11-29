//  File name   : RegisterProfileBuilder.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

// MARK: Dependency tree
protocol RegisterProfileDependency: Dependency {
    // todo: Declare the set of dependencies required by this RIB, but cannot be created by this RIB.
}

final class RegisterProfileComponent: Component<RegisterProfileDependency> {
    /// Class's public properties.
    let RegisterProfileVC: RegisterProfileVC
    
    /// Class's constructor.
    init(dependency: RegisterProfileDependency, RegisterProfileVC: RegisterProfileVC) {
        self.RegisterProfileVC = RegisterProfileVC
        super.init(dependency: dependency)
    }
    
    /// Class's private properties.
    // todo: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: Builder
protocol RegisterProfileBuildable: Buildable {
    func build(email: String) -> RegisterProfileRouting
}

final class RegisterProfileBuilder: Builder<RegisterProfileDependency>, RegisterProfileBuildable {
    /// Class's constructor.
    override init(dependency: RegisterProfileDependency) {
        super.init(dependency: dependency)
    }
    
    // MARK: RegisterProfileBuildable's members
    func build(email: String) -> RegisterProfileRouting {
        let vc = UIStoryboard.init(name: "LoginStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "RegisterProfileVC") as! RegisterProfileVC
        let component = RegisterProfileComponent(dependency: dependency, RegisterProfileVC: vc)

        let interactor = RegisterProfileInteractor(presenter: component.RegisterProfileVC, email: email)
        let tabbarBuilder = TabbarBuilder(dependency: component)
//        interactor.listener = listener

        // todo: Create builder modules builders and inject into router here.
        
        return RegisterProfileRouter(interactor: interactor, viewController: component.RegisterProfileVC, tabbarBuildable: tabbarBuilder)
    }
}
