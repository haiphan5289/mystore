//  File name   : TabbarVC.swift
//
//  Author      : MacbookPro
//  Created date: 11/23/19
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2019 MacbookPro. All rights reserved.
//  --------------------------------------------------------------

import RIBs
import UIKit

enum TabbarType: Int, CaseIterable {
    case home
    case message
    case myOrder
    case notify
    case profile
    
    var title: String {
        switch self {
        case .home:
            return Text.home.localizedText
        case .message:
            return Text.message.localizedText
        case .myOrder:
            return Text.myOrder.localizedText
        case .notify:
            return Text.notification.localizedText
        case .profile:
            return Text.profile.localizedText
        }
    }
    
    var icon: (normal: UIImage?, selected: UIImage?) {
        switch self {
        case .home:
            return (UIImage(named: "house"), UIImage(named: "house"))
        case .message:
            return (UIImage(named: "mess"), UIImage(named: "mess"))
        case .notify:
            return (UIImage(named: "notification"), UIImage(named: "notification"))
        case .myOrder:
            return (UIImage(named: "order"), UIImage(named: "order"))
        case .profile:
            return (UIImage(named: "profile"), UIImage(named: "profile"))
        }
        
    }
    
}

protocol TabbarPresentableListener: class {
    // todo: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TabbarVC: UITabBarController, TabbarPresentable, TabbarViewControllable {
    private struct Config {
    }
    
    /// Class's public properties.
    weak var listener: TabbarPresentableListener?
    let view_line = UIView()
    var leftViewLine: NSLayoutConstraint?
    var width_view: NSLayoutConstraint?

    // MARK: View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        viewLine()
        self.delegate = self
        let home = HomeController()
        let message = MessageVC()
        let myOrder = ViewController()
        let notify = ViewController()
        let profile = ProfileViewController()
        viewControllers = [home, message, myOrder, notify, profile]
        tabBar.backgroundColor = CustomColor.grey.getColor()
        TabbarType.allCases.forEach { (type) in
            if let controller = viewControllers {
                let item = controller[type.rawValue]
                item.tabBarItem.title = type.title
                item.tabBarItem.image = type.icon.normal
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
    }

    /// Class's private properties.
}

// MARK: View's event handlers
extension TabbarVC {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: Class's public methods
extension TabbarVC {
}

// MARK: Class's private methods
private extension TabbarVC {
    private func localize() {
        // todo: Localize view's here.
    }
    private func visualize() {
        // todo: Visualize view's here.
    }
    private func viewLine(){
        tabBar.addSubview(view_line)
        view_line.backgroundColor = CustomColor.orage.getColor()

        
        view_line.translatesAutoresizingMaskIntoConstraints = false
        leftViewLine = view_line.leftAnchor.constraint(equalTo: self.tabBar.leftAnchor, constant: 0)
        leftViewLine!.isActive = true
        view_line.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: 0).isActive = true
        width_view = view_line.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2)
        width_view!.isActive = true
        
        view_line.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
}
extension TabbarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        guard let view = self.tabBar.items?[tabBarIndex].value(forKey: "view") as? UIView else
        {
            return
        }
        switch tabBarIndex {
        case 0:
            moveViewLine(x: view.frame.origin.x - 2)
//            recent.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
        case 1:
            moveViewLine(x: view.frame.origin.x)
//            house.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
//            hide_text_recent()
        case 2:
            moveViewLine(x: view.frame.origin.x)
//            search.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
//            hide_text_recent()
        case 3:
            moveViewLine(x: view.frame.origin.x)
//            noti.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
//            hide_text_recent()
        default:
            moveViewLine(x: view.frame.origin.x)
//            profile.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
//            hide_text_recent()
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hide_text_recent(){
//        recent.tabBarItem.setTitleTextAttributes(nil, for: .highlighted)
    }
    
    func moveViewLine(x: CGFloat){
        leftViewLine?.constant = x
    }
}
