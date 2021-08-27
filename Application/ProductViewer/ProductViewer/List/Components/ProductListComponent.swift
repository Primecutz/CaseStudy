//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

class ProductListComponent: Component {
    
    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.configureViewWithItem(item)
        view.delegate = self
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed(item: item))
    }
    
}

// MARK: ProductListViewDelegate

extension ProductListComponent: ProductListViewDelegate {
    
    func addItemToShippingCart(_ item: ListItemViewState) {
        dispatcher?.triggerEvent(ShipButtonPressed(item: item))
    }
    
    func addItemToWishList(_ item: ListItemViewState) {
        dispatcher?.triggerEvent(B2ButtonPressed(item: item))
    }
    
}

// MARK: HarmonyLayoutComponent

extension ProductListComponent: HarmonyLayoutComponent {
    
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 150.0
    }
    
}
