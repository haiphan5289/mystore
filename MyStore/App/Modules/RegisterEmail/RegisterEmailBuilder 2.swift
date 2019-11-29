//  File name   : RegisterEmailBuilder.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

// MARK: Dependency tree
protocol RegisterEmailDependency: Dependency {
    // todo: Declare the set of dependencies required by this RIB, but cannot be created by this RIB.
}

final class RegisterEmailComponent: Component<RegisterEmailDependency> {
    /// Class's public properties.
    let RegisterEmailVC: RegisterEmailVC
    
    /// Class's constructor.
    init(dependency: RegisterEmailDependency, RegisterEmailVC: RegisterEmailVC) {
        self.RegisterEmailVC = RegisterEmailVC
        super.init(dependency: dependency)
    }
    
    /// Class's private properties.
    // todo: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: Builder
protocol RegisterEmailBuildable: Buildable {
    func build() -> RegisterEmailRouting
}

final class RegisterEmailBuilder: Builder<RegisterEmailDependency>, RegisterEmailBuildable {
    /// Class's constructor.
    override init(dependency: RegisterEmailDependency) {
        super.init(dependency: dependency)
    }
    
    // MARK: RegisterEmailBuildable's members
    func build() -> RegisterEmailRouting {
        let vc = UIStoryboard.init(name: "LoginStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "RegisterEmailVC") as! RegisterEmailVC
        let component = RegisterEmailComponent(dependency: dependency, RegisterEmailVC: vc)

        let interactor = RegisterEmailInteractor(presenter: component.RegisterEmailVC)
//        interactor.listener = listener
        let registerProfileBuilder = RegisterProfileBuilder(dependency: component)

        // todo: Create builder modules builders and inject into router here.
        
        return RegisterEmailRouter(interactor: interactor,
                                   viewController: component.RegisterEmailVC,
                                   registerProfikeBuildable: registerProfileBuilder)
    }
}
