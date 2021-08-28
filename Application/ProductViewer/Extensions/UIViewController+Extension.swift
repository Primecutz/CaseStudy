//
//  UIViewController+Extension.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var tabBarHeight: CGFloat {
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 49.0
        return tabBarHeight
    }
    
    func transitionToViewController(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = viewController
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
}
