//
//  Price.swift
//  DataSource
//
//  Created by David Truong on 8/26/21.
//

import Foundation
import Domain

public struct Price: Decodable {
    
    public let amountInCents: Int?
    public let currencySymbol: String?
    public let displayString: String?
    
    private enum CodingKeys: String, CodingKey {
        case amountInCents = "amount_in_cents"
        case currencySymbol = "currency_symbol"
        case displayString = "display_string"
    }
    
    func transferToPriceEntity() -> PriceEntity? {
        guard let amountInCents = amountInCents, let currencySymbol = currencySymbol, let displayString = displayString else { return nil }
        let priceEntity = PriceEntity(amountInCents: amountInCents,
                                      currencySymbol: currencySymbol,
                                      displayString: displayString)
        return priceEntity
    }

}
