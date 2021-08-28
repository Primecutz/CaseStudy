//
//  UIViewController+Extension.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func transitionToViewController(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = viewController
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
}
