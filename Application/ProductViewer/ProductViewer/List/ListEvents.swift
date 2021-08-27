//
//  ListEvents.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ListItemPressed: EventType {
    let item: ListItemViewState
}

struct ShipButtonPressed: EventType {
    let item: ListItemViewState
    
}

struct B2ButtonPressed: EventType {
    let item: ListItemViewState
}
