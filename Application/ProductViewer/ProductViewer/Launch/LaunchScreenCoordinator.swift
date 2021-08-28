//
//  LaunchScreenCoordinator.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo
import Domain

class LaunchScreenCoordinator: TempoCoordinator {
    
    // Class Properties
    let dispatcher = Dispatcher()
    
    // Presenters, view controllers, view state.
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    var viewState: LaunchScreenViewState? {
        didSet {
            updateUI()
        }
    }
    
    lazy var viewController: LaunchScreenViewController = {
        return LaunchScreenViewController.viewControllerFor(coordinator: self)
    }()
    
    required init() {
        updateState()
    }

}

// MARK: Private Functions

extension LaunchScreenCoordinator {
    
    private func updateUI() {
        guard let viewState = viewState else { return }
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    func updateState() {
        let launchScreenItem = LaunchScreenItemViewState(image: .target)
        viewState = LaunchScreenViewState(launchScreenItem: launchScreenItem)
    }
    
}
