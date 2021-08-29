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
    
    var viewState = ListViewState(listItems: []) {
        didSet {
            updateUI()
        }
    }
    
    var shoppingCart = [ListItemViewState]() {
        didSet {
            updateState()
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

// MARK: Private Functions

extension CartCoordinator {
    
    private func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    private func updateState() {
        viewState.listItems = []
        viewState.listItems = shoppingCart
    }
    
    private func registerListeners() {
        dispatcher.addObserver(CartItemPressed.self) { [weak self] event in
            let detailCoordinator = DealsDetailDependencyInjector().setupDealsDetailDependencies()
            detailCoordinator.productId = event.item.id
            let detailVC = detailCoordinator.viewController
            self?.viewController.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        dispatcher.addObserver(UpdateQuantityPressed.self) { event in
            let itemName = event.item.title
            let addOrRemove = event.add ? "Add" : "Remove"
            print("\(addOrRemove) one quantity from \(itemName)")
        }
        
        dispatcher.addObserver(RemoveItemPressed.self) { event in
            let itemName = event.item.title
            print("Remove \(itemName) from cart")
        }
    }
    
}
