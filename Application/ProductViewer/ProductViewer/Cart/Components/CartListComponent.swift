//
//  CartListComponent.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

class CartListComponent: Component {
    
    var dispatcher: Dispatcher?

    func prepareView(_ view: CartListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: CartListView, item: ListItemViewState) {
        view.configureViewWithItem(item)
        view.delegate = self
    }
    
    func selectView(_ view: CartListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(CartItemPressed(item: item))
    }
    
}

// MARK: CartListViewDelegate

extension CartListComponent: CartListViewDelegate {
    
    func updateItemQuantity(_ item: ListItemViewState, add: Bool) {
        dispatcher?.triggerEvent(UpdateQuantityPressed(item: item, add: add))
    }
    
    func removeItemFromShippingCart(_ item: ListItemViewState) {
        dispatcher?.triggerEvent(RemoveItemPressed(item: item))
    }
    
}

// MARK: HarmonyLayoutComponent

extension CartListComponent: HarmonyLayoutComponent {
    
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 150.0
    }
    
}
