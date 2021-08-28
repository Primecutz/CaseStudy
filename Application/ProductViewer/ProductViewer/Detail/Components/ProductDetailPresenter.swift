//
//  ProductDetailPresenter.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

class ProductDetailPresenter: TempoPresenter {
    
    let productDetailView: ProductDetailView
    
    var dispatcher: Dispatcher?

    required init(productDetailView: ProductDetailView) {
        self.productDetailView = productDetailView
    }
    
    func present(_ viewState: DetailViewState) {
        productDetailView.configureView(viewState)
        productDetailView.delegate = self
    }
    
}

// MARK: ProductListViewDelegate

extension ProductDetailPresenter: ProductDetailViewDelegate {
    
    func addItemToShippingCart(_ item: DetailItemViewState) {
        dispatcher?.triggerEvent(AddToCartButtonPressed(item: item))
    }
    
    func addItemToWishList(_ item: DetailItemViewState) {
        dispatcher?.triggerEvent(AddToListButtonPressed(item: item))
    }
    
}
