//  File name   : PostProductBuilder.swift
//
//  Author      : MacbookPro
//  Created date: 11/29/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
//import FwiCore

// MARK: Dependency tree
protocol PostProductDependency: Dependency {
    // todo: Declare the set of dependencies required by this RIB, but cannot be created by this RIB.
}

final class PostProductComponent: Component<PostProductDependency> {
    /// Class's public properties.
    let PostProductVC: PostProductVC
    
    /// Class's constructor.
    init(dependency: PostProductDependency, PostProductVC: PostProductVC) {
        self.PostProductVC = PostProductVC
        super.init(dependency: dependency)
    }
    
    /// Class's private properties.
    // todo: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: Builder
protocol PostProductBuildable: Buildable {
    func build(withListener listener: PostProductListener) -> PostProductRouting
}

final class PostProductBuilder: Builder<PostProductDependency>, PostProductBuildable {
    /// Class's constructor.
    override init(dependency: PostProductDependency) {
        super.init(dependency: dependency)
    }
    
    // MARK: PostProductBuildable's members
    func build(withListener listener: PostProductListener) -> PostProductRouting {
        let vc = PostProductVC(nibName: "PostProductVC", bundle: nil)
        let component = PostProductComponent(dependency: dependency, PostProductVC: vc)

        let interactor = PostProductInteractor(presenter: component.PostProductVC)
        interactor.listener = listener

        // todo: Create builder modules builders and inject into router here.
        
        return PostProductRouter(interactor: interactor, viewController: component.PostProductVC)
    }
}
