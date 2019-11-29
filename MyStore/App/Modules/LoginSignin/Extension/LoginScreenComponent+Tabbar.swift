//  File name   : LoginScreenComponent+Tabbar.swift
//
//  Author      : MacbookPro
//  Created date: 11/27/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

/// The dependencies needed from the parent scope of LoginScreen to provide for the Tabbar scope.
// todo: Update LoginScreenDependency protocol to inherit this protocol.
protocol LoginScreenDependencyTabbar: Dependency {
    // todo: Declare dependencies needed from the parent scope of LoginScreen to provide dependencies
    // for the Tabbar scope.
}

extension LoginScreenComponent: TabbarDependency {

    // todo: Implement properties to provide for Tabbar scope.
}
