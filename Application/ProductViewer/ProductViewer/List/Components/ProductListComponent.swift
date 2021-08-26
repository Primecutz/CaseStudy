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
        view.addShipButtonTarget(self, action: #selector(shipButtonPressed))
        view.addB2ButtonTarget(self, action: #selector(b2ButtonPressed))
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.configureViewWithItem(item)
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed())
    }
    
}

// MARK: Button Actions

extension ProductListComponent {
    
    @objc private func shipButtonPressed() {
        dispatcher?.triggerEvent(ShipButtonPressed())
    }
    
    @objc private func b2ButtonPressed() {
        dispatcher?.triggerEvent(B2ButtonPressed())
    }
    
}

extension ProductListComponent: HarmonyLayoutComponent {
    
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 150.0
    }
    
}
