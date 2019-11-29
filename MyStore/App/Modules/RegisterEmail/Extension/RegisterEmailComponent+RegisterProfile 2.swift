//  File name   : RegisterEmailComponent+RegisterProfile.swift
//
//  Author      : MacbookPro
//  Created date: 11/18/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs

/// The dependencies needed from the parent scope of RegisterEmail to provide for the RegisterProfile scope.
// todo: Update RegisterEmailDependency protocol to inherit this protocol.
protocol RegisterEmailDependencyRegisterProfile: Dependency {
    // todo: Declare dependencies needed from the parent scope of RegisterEmail to provide dependencies
    // for the RegisterProfile scope.
}

extension RegisterEmailComponent: RegisterProfileDependency {

    // todo: Implement properties to provide for RegisterProfile scope.
}
