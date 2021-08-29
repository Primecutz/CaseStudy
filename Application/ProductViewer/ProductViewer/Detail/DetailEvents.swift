//
//  DetailEvents.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

struct AddToCartButtonPressed: EventType {
    let item: DetailItemViewState
}

struct AddToListButtonPressed: EventType {
    let item: DetailItemViewState
}
