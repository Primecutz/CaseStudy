//
//  Configuration.swift
//  ProductViewer
//
//  Created by David Truong on 8/26/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

struct Configuration {
    #if Development
    static let baseApiUrl = "https://api.target.com/mobile_case_study_deals/v1"
    #elseif Staging
    static let baseApiUrl = "https://api.target.com/mobile_case_study_deals/v1"
    #else
    static let baseApiUrl = "https://api.target.com/mobile_case_study_deals/v1"
    #endif
}
