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
    var quantityInCart: Int?
}

func == (lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
    return lhs.id == rhs.id
}
