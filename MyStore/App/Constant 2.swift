//
//  Constant.swift
//  MyStore
//
//  Created by MacbookPro on 11/3/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit

enum Constant: Int {
    case btRadiusLogin = 20
    case muoi = 100
    
    var value: Int {
        return rawValue
    }
    
    static func getCaseEnum(status: Int) -> Constant {
        if status == Config.muoi {
            return.muoi
        }
        return .btRadiusLogin
    }
    
    struct Config {
        static let muoi = 10
    }
    
}

enum CustomColor {
    case blue, green, black, grey
    
    func getColor() -> UIColor {
        switch self {
        case .blue:
           return UIColor(red: 61/255, green: 101/255, blue: 161/255, alpha: 1)
        case .green:
            return UIColor(red: 51/255, green: 131/255, blue: 63/255, alpha: 1)
        case .black:
            return UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
        case .grey:
            return UIColor(red: 99/255, green: 114/255, blue: 128/255, alpha: 1)
        }
    }
}
