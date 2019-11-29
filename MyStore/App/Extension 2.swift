//
//  Extension.swift
//  MyStore
//
//  Created by MacbookPro on 11/11/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit

protocol Weakifiable: AnyObject {}
extension Weakifiable {
    func weakify(_ code: @escaping (Self) -> Void) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            code(self)
        }
    }
    
    func weakify<T>(_ code: @escaping (T, Self) -> Void) -> (T) -> Void {
        return { [weak self] arg in
            guard let self = self else { return }
            code(arg, self)
        }
    }
}

extension UIViewController: Weakifiable {}
extension UIViewController {
    func showLoading() -> UIAlertController{
        let alert: UIAlertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        let activies: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activies.color = .blue
        activies.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        alert.view.addConstraint(height)
        let width:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        alert.view.addConstraint(width)
        alert.view.addSubview(activies)
        activies.startAnimating()
        present(alert, animated: true, completion: nil)
        return alert
    }
}
