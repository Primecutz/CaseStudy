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

    func prepareView(_ view: CartListView, item: CartItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: CartListView, item: CartItemViewState) {
        view.configureViewWithItem(item)
        view.delegate = self
    }
    
    func selectView(_ view: CartListView, item: CartItemViewState) {
        dispatcher?.triggerEvent(CartItemPressed(item: item))
    }
    
    func updateView(_ view: CartListView, item: CartItemViewState) {
        view.updateItemQuantity(item)
    }
    
}

// MARK: CartListViewDelegate

extension CartListComponent: CartListViewDelegate {
    
    func updateItemQuantity(_ item: CartItemViewState, view: CartListView, add: Bool) {
        var itemToUpdate = item
        if add {
            itemToUpdate.quantityInCart += 1
            updateView(view, item: itemToUpdate)
            dispatcher?.triggerEvent(UpdateQuantityPressed(item: itemToUpdate))
        } else if itemToUpdate.quantityInCart > 1 {
            itemToUpdate.quantityInCart -= 1
            updateView(view, item: itemToUpdate)
            dispatcher?.triggerEvent(UpdateQuantityPressed(item: itemToUpdate))
        }
    }
    
    func removeItemFromShippingCart(_ item: CartItemViewState) {
        dispatcher?.triggerEvent(RemoveItemPressed(item: item))
    }
    
}

// MARK: HarmonyLayoutComponent

extension CartListComponent: HarmonyLayoutComponent {
    
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 150.0
    }
    
}
