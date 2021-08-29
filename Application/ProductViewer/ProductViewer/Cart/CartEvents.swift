//
//  CartEvents.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

struct CartItemPressed: EventType {
    let item: CartItemViewState
}

struct UpdateQuantityPressed: EventType {
    let item: CartItemViewState
}

struct RemoveItemPressed: EventType {
    let item: CartItemViewState
}
