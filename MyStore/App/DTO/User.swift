//
//  User.swift
//  MyStore
//
//  Created by MacbookPro on 11/3/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit
import Firebase

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
struct UserFireBase {
    let id: String?
    let password: String?
    let firstName: String?
    let lastName: String?
    let urlProfile: String?
    let email: String?
    
    init(id: String, password: String, firstName: String, lastName: String, urlProfile: String, email: String) {
        self.id = id
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.urlProfile = urlProfile
        self.email = email
    }
    init(snapshot: DataSnapshot) {
        let temp = snapshot.value as? [String: Any]
        self.id = temp?["id"] as? String
        self.password = temp?["password"] as? String
        self.firstName = temp?["firstName"] as? String
        self.lastName = temp?["lastName"] as? String
        self.urlProfile = temp?["urlProfile"] as? String
        self.email = temp?["email"] as? String
    }
    
}
struct ProductsFirebase {
    let title: String?
    let price: String?
    let description: String?
    let arrayImage: [String]?
    init(title: String, price: String, description: String, arrayImage: [String]) {
        self.title = title
        self.price = price
        self.description = description
        self.arrayImage = arrayImage
    }
    init(snapshot: DataSnapshot) {
        let tem = snapshot.value as? [String:Any]
        self.title = tem?["title"] as? String
        self.price = tem?["price"] as? String
        self.description = tem?["description"] as? String
        self.arrayImage = tem?["arrayImage"] as? [String]
    }
}
