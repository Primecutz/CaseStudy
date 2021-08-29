//
//  Product.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

struct Product: Equatable {
    
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
    let price: String
    var quantityInCart: Int
    
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

struct ShoppingCart {
    static var shared = [Product]()
}
