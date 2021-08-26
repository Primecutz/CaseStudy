//
//  ProductEntity.swift
//  Domain
//
//  Created by David Truong on 8/26/21.
//

import Foundation

public struct ProductEntity {
    
    public let id: Int
    public let title: String
    public let aisle: String
    public let description: String
    public let imageUrl: String
    public let regularPrice: PriceEntity
    
    internal init(id: Int, title: String, aisle: String, description: String, imageUrl: String, regularPrice: PriceEntity) {
        self.id = id
        self.title = title
        self.aisle = aisle
        self.description = description
        self.imageUrl = imageUrl
        self.regularPrice = regularPrice
    }
    
}
