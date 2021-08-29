//
//  DetailCoordinator.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo
import Domain

class DetailCoordinator: TempoCoordinator {
    
    // Class Properties
    private let productDetailInteractor: ProductDetailInteractor
    let dispatcher = Dispatcher()
    
    // Presenters, view controllers, view state.
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    var viewState: DetailViewState? {
        didSet {
            updateUI()
        }
    }
    
    var productId: Int? {
        didSet {
            updateState()
        }
    }
    
    lazy var viewController: DetailViewController = {
        return DetailViewController.viewControllerFor(coordinator: self)
    }()
    
    // Object Lifecycle
    required init(productDetailInteractor: ProductDetailInteractor) {
        self.productDetailInteractor = productDetailInteractor
        registerListeners()
    }

}

// MARK: Private Functions

extension DetailCoordinator {
    
    private func updateUI() {
        guard let viewState = viewState else { return }
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    func updateState() {
        fetchProduct()
    }
    
    private func registerListeners() {
        dispatcher.addObserver(AddToCartButtonPressed.self) { [weak self] event in
            self?.addItemToCart(event.item)
        }
        
        dispatcher.addObserver(AddToListButtonPressed.self) { event in
            // Todo: Add to wish list
            let itemName = event.item.title
            print("Added \(itemName) to wish list")
        }
    }
    
    private func addItemToCart(_ item: DetailItemViewState) {
        let product = item.transferToProduct()
        if ShoppingCart.shared.contains(product) {
            print("\(item.title) already in cart")
        } else {
            ShoppingCart.shared.append(product)
            print("Add \(item.title) to shopping cart")
        }
    }
    
}

// MARK: API Calls

extension DetailCoordinator {
    
    private func fetchProduct() {
        guard let productId = productId else { return }
        productDetailInteractor.execute(fetchProduct: productId) { [weak self] result in
            switch result {
            case .success(let productEntity):
                guard let product = productEntity, let displayPrice = product.regularPrice?.displayString else { return }
                let detailItem = DetailItemViewState(id: product.id, title: product.title, description: product.description, price: displayPrice, imageUrl: product.imageUrl)
                self?.viewState = DetailViewState(detailItem: detailItem)
            case .failure(let errorMessageEntity):
                print(errorMessageEntity.message)
            }
        }
    }
    
}
