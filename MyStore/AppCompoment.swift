//
//  AppCompoment.swift
//  MyStore
//
//  Created by MacbookPro on 11/16/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//
import RIBs

class AppCompoment: Component<EmptyDependency>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
