//
//  CartViewState.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

struct CartViewState: TempoViewState, TempoSectionedViewState {
    var cartItems: [TempoViewStateItem]
    var sections: [TempoViewStateItem] { return cartItems }
}

struct CartItemViewState: TempoViewStateItem, Equatable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let imageUrl: String
    var quantityInCart: Int
    
    func transferToProduct() -> Product {
        let product = Product(id: id,
                              title: title,
                              description: description,
                              imageUrl: imageUrl,
                              price: price,
                              quantityInCart: quantityInCart)
        return product
    }
}

func == (lhs: CartItemViewState, rhs: CartItemViewState) -> Bool {
    return lhs.id == rhs.id
}
