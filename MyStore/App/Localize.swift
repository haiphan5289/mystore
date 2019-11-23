//
//  Localize.swift
//  MyStore
//
//  Created by MacbookPro on 11/3/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//
import  UIKit

enum Text: String {
    //a
    case alreadyAccount = "Bạn đã có tài khoản"
    //c
    case cancel = "Huỷ"
    //d
    case desSlogan = "Chúng tôi sẽ mang tới trải nghiêm tuyệt vời"
    case desPolicies = "Khi bạn đăng kí, bạn đã chấp nhận điều khoản cuản chúng tôi"
    //e
    case email = "Email"
    //f
    case firstName = "Tên đầu tiên"
    //l
    case lastName = "Tên cuối cùng"
    //n
    case next = "Tiếp tục"
    case namePictureProfile = "Tải hình đại diện"
    //m
    //p
    case password = "Mật khẩu"
    //r
    case registerWithFacebook = "Đăng kí với Facebook"
    case registerWithGmail = "Đăng kí với Gmail"
    case register = "Đăng ký"
    //s
    case slogan = "Chào mừng tới 2! Mobile"
    case signIn = "Đăng nhập"
    //y
    case yourEmail = "Email của bạn là gì"
    
    var text: String {
        return rawValue
    }
    
    var localizedText: String {
        return NSLocalizedString(text, comment: "")
    }
}
