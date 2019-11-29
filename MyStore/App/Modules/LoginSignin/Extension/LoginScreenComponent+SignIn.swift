//  File name   : LoginScreenComponent+SignIn.swift
//
//  Author      : MacbookPro
//  Created date: 11/26/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

/// The dependencies needed from the parent scope of LoginScreen to provide for the SignIn scope.
// todo: Update LoginScreenDependency protocol to inherit this protocol.
protocol LoginScreenDependencySignIn: Dependency {
    // todo: Declare dependencies needed from the parent scope of LoginScreen to provide dependencies
    // for the SignIn scope.
}

extension LoginScreenComponent: SignInDependency {

    // todo: Implement properties to provide for SignIn scope.
}
