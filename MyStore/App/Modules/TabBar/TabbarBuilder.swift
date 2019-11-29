//  File name   : TabbarBuilder.swift
//
//  Author      : MacbookPro
//  Created date: 11/23/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

// MARK: Dependency tree
protocol TabbarDependency: Dependency {
    // todo: Declare the set of dependencies required by this RIB, but cannot be created by this RIB.
}

final class TabbarComponent: Component<TabbarDependency> {
    /// Class's public properties.
    let TabbarVC: TabbarVC
    
    /// Class's constructor.
    init(dependency: TabbarDependency, TabbarVC: TabbarVC) {
        self.TabbarVC = TabbarVC
        super.init(dependency: dependency)
    }
    
    /// Class's private properties.
    // todo: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: Builder
protocol TabbarBuildable: Buildable {
    func build(withListener listener: TabbarListener) -> TabbarRouting
}

final class TabbarBuilder: Builder<TabbarDependency>, TabbarBuildable {
    /// Class's constructor.
    override init(dependency: TabbarDependency) {
        super.init(dependency: dependency)
    }
    
    // MARK: TabbarBuildable's members
    func build(withListener listener: TabbarListener) -> TabbarRouting {
        let vc = TabbarVC()
        let component = TabbarComponent(dependency: dependency, TabbarVC: vc)

        let interactor = TabbarInteractor(presenter: component.TabbarVC)
        interactor.listener = listener

        // todo: Create builder modules builders and inject into router here.
        
        return TabbarRouter(interactor: interactor, viewController: component.TabbarVC)
    }
}
