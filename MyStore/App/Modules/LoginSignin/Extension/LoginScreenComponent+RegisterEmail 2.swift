//  File name   : LoginScreenComponent+RegisterEmail.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

/// The dependencies needed from the parent scope of LoginScreen to provide for the RegisterEmail scope.
// todo: Update LoginScreenDependency protocol to inherit this protocol.
protocol LoginScreenDependencyRegisterEmail: Dependency {
    // todo: Declare dependencies needed from the parent scope of LoginScreen to provide dependencies
    // for the RegisterEmail scope.
}

extension LoginScreenComponent: RegisterEmailDependency {

    // todo: Implement properties to provide for RegisterEmail scope.
}
