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
    var shoppingCart = [ListItemViewState]()
    
    // Presenters, view controllers, view state.
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    var viewState = ListViewState(listItems: []) {
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
        viewState.listItems = []
        viewState.listItems = shoppingCart
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
            let detailCoordinator = DealsDetailDependencyInjector().setupDealsDetailDependencies()
            detailCoordinator.productId = event.item.id
            let detailVC = detailCoordinator.viewController
            self?.viewController.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        dispatcher.addObserver(UpdateQuantityPressed.self) { [weak self] event in
            self?.updateShoppingCart(event.item)
        }
        
        dispatcher.addObserver(RemoveItemPressed.self) { [weak self] event in
            self?.removeItemFromCart(event.item)
        }
    }
    
    private func updateShoppingCart(_ item: ListItemViewState) {
        guard let indexOfItem = shoppingCart.firstIndex(of: item) else { return }
        shoppingCart[indexOfItem] = item
    }
    
    private func removeItemFromCart(_ item: ListItemViewState) {
        guard let indexOfItem = shoppingCart.firstIndex(of: item) else { return }
        shoppingCart.remove(at: indexOfItem)
        updateState()
    }
    
}
