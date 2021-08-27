//
//  PriceEntity.swift
//  Domain
//
//  Created by David Truong on 8/26/21.
//

import Foundation

public struct PriceEntity {
    
    public let amountInCents: Int
    public let currencySymbol: String
    public let displayString: String
    
    public init(amountInCents: Int, currencySymbol: String, displayString: String) {
        self.amountInCents = amountInCents
        self.currencySymbol = currencySymbol
        self.displayString = displayString
    }
    
}
