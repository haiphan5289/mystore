//
//  fw.swift
//  MyStore
//
//  Created by MacbookPro on 11/18/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import UIKit
import SnapKit
import Photos

enum FirebaseTable {
    case users
    
    func getTableUser() -> String {
        switch self {
        case .users:
            return "Users"
        }
    }
}

class fw {
    static let share = fw()
    var dataBase = Database.database().reference()
    let storage = Storage.storage().reference()
    //hàm kiểm tra text field là email
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
}

