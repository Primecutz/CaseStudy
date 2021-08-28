//
//  UIImage+Extension.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

extension UIImage {
    
    // Logos
    static let target = UIImage(named: "Target")?.withRenderingMode(.alwaysOriginal)
    static let targetBrand = UIImage(named: "TargetBrand")?.withRenderingMode(.alwaysOriginal)
    
    // Tab Icons
    static let dealsTab = UIImage(named: "DealsTab")?.withRenderingMode(.alwaysTemplate)
    static let cartTab = UIImage(named: "CartTab")?.withRenderingMode(.alwaysTemplate)
    
}
