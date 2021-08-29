//
//  DetailViewState.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

struct DetailViewState: TempoViewState {
    var detailItem: DetailItemViewState
}

struct DetailItemViewState: TempoViewStateItem, Equatable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let imageUrl: String
    
    func transferToProduct() -> Product {
        let product = Product(id: id,
                              title: title,
                              description: description,
                              imageUrl: imageUrl,
                              price: price,
                              quantityInCart: 1)
        return product
    }
}

func == (lhs: DetailItemViewState, rhs: DetailItemViewState) -> Bool {
    return lhs.id == rhs.id
}
