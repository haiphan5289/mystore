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
    case changePassword = "Đổi mật khẩu"
    //d
    case desSlogan = "Chúng tôi sẽ mang tới trải nghiêm tuyệt vời"
    case desPolicies = "Khi bạn đăng kí, bạn đã chấp nhận điều khoản cuản chúng tôi"
    case description = "Mô tả"
    case detail = "Chi tiết"
    //e
    case email = "Email"
    //f
    case firstName = "Tên đầu tiên"
    case forgotYourPassword = "Quên mật khẩu"
    //h
    case home = "Trang chủ"
    //i
    case inputTitle = "Nhập nội dung vào tiêu đề"
    case inputPrice = "Nhập nội dung vào giá"
    case inputDescription = "Nhập nội dung vào mô tả"
    //l
    case lastName = "Tên cuối cùng"
    //n
    case next = "Tiếp tục"
    case namePictureProfile = "Tải hình đại diện"
    case notification = "Thông báo"
    //m
    case message = "Tin nhắn"
    case myOrder = "Đơn hàng"
    //p
    case password = "Mật khẩu"
    case profile = "Cá nhân"
    case postProduct = "Đăng sản phẩm"
    case price = "Giá"
    //r
    case registerWithFacebook = "Đăng kí với Facebook"
    case registerWithGmail = "Đăng kí với Gmail"
    case register = "Đăng ký"
    //s
    case slogan = "Chào mừng tới 2! Mobile"
    case signIn = "Đăng nhập"
    case somethingError = "Đã có lỗi xảy ra"
    case signOut = "Đăng xuât"
    //t
    case title = "Tiêu đề"
    //y
    case yourEmail = "Email của bạn là gì"
    
    var text: String {
        return rawValue
    }
    
    var localizedText: String {
        return NSLocalizedString(text, comment: "")
    }
}
