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
            self?.presentItemDetail(event.item)
        }
        
        dispatcher.addObserver(ShipButtonPressed.self) { [weak self] event in
            self?.addItemToCart(event.item)
        }
        
        dispatcher.addObserver(B2ButtonPressed.self) { event in
            // Todo: Add to wish list
            let itemName = event.item.title
            print("Add \(itemName) to wish list")
        }
    }
    
    private func presentItemDetail(_ item: ListItemViewState) {
        let detailCoordinator = DealsDetailDependencyInjector().setupDealsDetailDependencies()
        detailCoordinator.productId = item.id
        let detailVC = detailCoordinator.viewController
        self.viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func addItemToCart(_ item: ListItemViewState) {
        if let indexOfItem = shoppingCart.firstIndex(of: item) {
            shoppingCart[indexOfItem].quantityInCart += 1
            print("Add one more to \(item.title) in shopping cart")
        } else {
            shoppingCart.append(item)
            print("Add \(item.title) to shopping cart")
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
                        return ListItemViewState(id: $0.id, title: $0.title, description: $0.description, price: displayPrice, imageUrl: $0.imageUrl, quantityInCart: 1)
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
