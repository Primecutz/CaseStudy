//
//  Product.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

class Product {
    
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
    let price: String
    var quantityInCart: Int
    
    static var shoppingCart = [Product]()
    
    init(id: Int, title: String, description: String, imageUrl: String, price: String, quantityInCart: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.price = price
        self.quantityInCart = quantityInCart
    }
    
}

extension Product: Equatable {
    
    func transferToCartItemViewState() -> CartItemViewState {
        let cartItemViewState = CartItemViewState(id: id,
                                                  title: title,
                                                  description: description,
                                                  price: price,
                                                  imageUrl: imageUrl,
                                                  quantityInCart: quantityInCart)
        return cartItemViewState
    }
    
}

func == (lhs: Product, rhs: Product) -> Bool {
    return lhs.id == rhs.id
}
