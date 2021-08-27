//
//  Product.swift
//  DataSource
//
//  Created by David Truong on 8/26/21.
//

import Foundation
import Domain

public struct Product: Decodable {
    
    public let id: Int?
    public let title: String?
    public let aisle: String?
    public let description: String?
    public let imageUrl: String?
    public let regularPrice: Price?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case aisle
        case description
        case imageUrl = "image_url"
        case regularPrice = "regular_price"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(Int.self, forKey: .id)
        self.title = try? container.decode(String.self, forKey: .title)
        self.aisle = try? container.decode(String.self, forKey: .aisle)
        self.description = try? container.decode(String.self, forKey: .description)
        self.imageUrl = try? container.decode(String.self, forKey: .imageUrl)
        self.regularPrice = try? container.decode(Price.self, forKey: .regularPrice)
    }
    
    func transferToProductEntity() -> ProductEntity? {
        guard let id = id else { return nil }
        let priceEntity = regularPrice?.transferToPriceEntity()
        let productEntity = ProductEntity(id: id,
                                          title: title ?? "",
                                          aisle: aisle ?? "",
                                          description: description ?? "",
                                          imageUrl: imageUrl ?? "",
                                          regularPrice: priceEntity)
        return productEntity
    }
    
}
