//
//  ProfileStream.swift
//  MyStore
//
//  Created by MacbookPro on 11/29/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit
import Firebase

class Profile {
    static let share = Profile()
    var id: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var urlProfile: String?
    var email: String?
    
    func inputProfile(user: UserFireBase) {
        self.id = user.id
        self.password = user.password
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.urlProfile = user.urlProfile
        self.email = user.email
    }
    
    func getProfile() -> UserFireBase {
        let u: UserFireBase = UserFireBase(id: self.id ?? "0",
                                           password: self.password ?? "0",
                                           firstName: self.firstName ?? "0",
                                           lastName: self.lastName ?? "0",
                                           urlProfile: self.urlProfile ?? "0",
                                           email: self.email ?? "0")
        return u
    }
}
