//
//  User.swift
//  MyStore
//
//  Created by MacbookPro on 11/3/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit

struct User: Codable {
    let id: String?
    let name: String?
//    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
//        case email = "email"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
//        email = try values.decode(String.self, forKey: .email)
    }

}
struct UserFireBase: Codable {
    let id: String?
    let password: String?
    let firstName: String?
    let lastName: String?
    let urlProfile: String?
    let email: String?
    
    enum Codingkeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case urlProfile = "urlProfile"
        case password = "password"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        password = try values.decode(String.self, forKey: .password)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        urlProfile = try values.decode(String.self, forKey: .urlProfile)
        email = try values.decode(String.self, forKey: .email)
        
    }
}
