//  File name   : RootComponent+LoginScreen.swift
//
//  Author      : MacbookPro
//  Created date: 11/16/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoginScreen scope.
// todo: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyLoginScreen: Dependency {
    // todo: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoginScreen scope.
}

extension RootComponent: LoginScreenDependency {

    // todo: Implement properties to provide for LoginScreen scope.
}
