//
//  CartCoordinator.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo
import Domain

class CartCoordinator: TempoCoordinator {
    
    // Class Properties
    let dispatcher = Dispatcher()
    
    // Presenters, view controllers, view state.
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    var viewState = CartViewState(cartItems: []) {
        didSet {
            updateUI()
        }
    }
    
    lazy var viewController: CartViewController = {
        return CartViewController.viewControllerFor(coordinator: self)
    }()
    
    // Object Lifecycle
    required init() {
        registerListeners()
    }

}

// MARK: Public Functions

extension CartCoordinator {
    
    func updateState() {
        viewState.cartItems = []
        viewState.cartItems = Product.shoppingCart.map { return $0.transferToCartItemViewState() }
    }
    
}

// MARK: Private Functions

extension CartCoordinator {
    
    private func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    private func registerListeners() {
        dispatcher.addObserver(CartItemPressed.self) { [weak self] event in
            self?.presentItemDetail(event.item)
        }
        
        dispatcher.addObserver(UpdateQuantityPressed.self) { [weak self] event in
            self?.updateShoppingCart(event.item)
        }
        
        dispatcher.addObserver(RemoveItemPressed.self) { [weak self] event in
            self?.removeItemFromCart(event.item)
        }
    }
    
    private func presentItemDetail(_ item: CartItemViewState) {
        let detailCoordinator = DealsDetailDependencyInjector().setupDealsDetailDependencies()
        detailCoordinator.productId = item.id
        let detailVC = detailCoordinator.viewController
        self.viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func updateShoppingCart(_ item: CartItemViewState) {
        let product = item.transferToProduct()
        guard let indexOfItem = Product.shoppingCart.firstIndex(of: product) else { return }
        Product.shoppingCart[indexOfItem] = product
    }
    
    private func removeItemFromCart(_ item: CartItemViewState) {
        let product = item.transferToProduct()
        guard let indexOfItem = Product.shoppingCart.firstIndex(of: product) else { return }
        Product.shoppingCart.remove(at: indexOfItem)
        updateState()
    }
    
}
