//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo
import Domain

class ListCoordinator: TempoCoordinator {
    
    // Class Properties
    private let productListInteractor: ProductListInteractor
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
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // Object Lifecycle
    required init(productListInteractor: ProductListInteractor) {
        self.productListInteractor = productListInteractor
        updateState()
        registerListeners()
    }

}

// MARK: Private Functions

extension ListCoordinator {
    
    private func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    private func updateState() {
        fetchDeals()
    }
    
    private func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] event in
            let detailCoordinator = DealsDetailDependencyInjector().setupDealsDetailDependencies()
            detailCoordinator.productId = event.item.id
            let detailVC = detailCoordinator.viewController
            self?.viewController.present(detailVC, animated: true)
        }
        
        dispatcher.addObserver(ShipButtonPressed.self) { event in
            // Todo: Add to shipping cart
            let itemName = event.item.title
            print("Added \(itemName) to shopping cart")
        }
        
        dispatcher.addObserver(B2ButtonPressed.self) { event in
            // Todo: Add to wish list
            let itemName = event.item.title
            print("Added \(itemName) to wish list")
        }
    }
    
}

// MARK: API Calls

extension ListCoordinator {
    
    private func fetchDeals() {
        productListInteractor.execute { [weak self] result in
            switch result {
            case .success(let productEntities):
                self?.viewState.listItems = productEntities.compactMap {
                    if let displayPrice = $0.regularPrice?.displayString {
                        return ListItemViewState(id: $0.id, title: $0.title, description: $0.description, price: displayPrice, imageUrl: $0.imageUrl)
                    } else {
                        return nil
                    }
                }
            case .failure(let errorMessageEntity):
                print(errorMessageEntity.message)
            }
        }
    }
    
}
