//  File name   : ProfileViewControllerComponent+PostProduct.swift
//
//  Author      : MacbookPro
//  Created date: 11/29/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

/// The dependencies needed from the parent scope of ProfileViewController to provide for the PostProduct scope.
// todo: Update ProfileViewControllerDependency protocol to inherit this protocol.
protocol ProfileViewControllerDependencyPostProduct: Dependency {
    // todo: Declare dependencies needed from the parent scope of ProfileViewController to provide dependencies
    // for the PostProduct scope.
}

extension ProfileComponent: PostProductDependency {

    // todo: Implement properties to provide for PostProduct scope.
}
