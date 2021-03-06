//
//  ListViewState.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ListViewState: TempoViewState, TempoSectionedViewState {
    var listItems: [TempoViewStateItem]
    var sections: [TempoViewStateItem] { return listItems }
}

struct ListItemViewState: TempoViewStateItem, Equatable {
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

func == (lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
    return lhs.id == rhs.id
}
