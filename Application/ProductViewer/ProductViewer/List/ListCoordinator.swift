//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

class ListCoordinator: TempoCoordinator {
    
    // Class Properties
    let dispatcher = Dispatcher()
    
    // MARK: Presenters, view controllers, view state.
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    private var viewState: ListViewState {
        didSet {
            updateUI()
        }
    }
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    required init() {
        viewState = ListViewState(listItems: [])
        updateState()
        registerListeners()
    }

}

// MARK: ListCoordinator

extension ListCoordinator {
    
    private func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    private func updateState() {
        viewState.listItems = (1..<10).map { index in
            ListItemViewState(title: "Puppies!!!", price: "$9.99", image: UIImage(named: "\(index)"))
        }
    }
    
    private func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] e in
            let alert = UIAlertController(title: "Item selected!", message: "🐶", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
            self?.viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
