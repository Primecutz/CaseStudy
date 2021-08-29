//
//  CartEvents.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

struct CartItemPressed: EventType {
    let item: ListItemViewState
}

struct UpdateQuantityPressed: EventType {
    let item: ListItemViewState
}

struct RemoveItemPressed: EventType {
    let item: ListItemViewState
}
