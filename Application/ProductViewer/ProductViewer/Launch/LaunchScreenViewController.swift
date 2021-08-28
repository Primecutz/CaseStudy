//
//  LaunchScreenViewController.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

class LaunchScreenViewController: UIViewController {
    
    // Class Properties
    private var coordinator: TempoCoordinator
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> LaunchScreenViewController {
        let viewController = LaunchScreenViewController(coordinator: coordinator)
        return viewController
    }
    
    // View Properties
    private lazy var launchScreenView: LaunchScreenView = {
        let launchScreenView = LaunchScreenView()
        return launchScreenView
    }()
    
    // View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentMainApp()
    }
    
    // Object Lifecycle
    required init(coordinator: TempoCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Setup Views

extension LaunchScreenViewController {
    
    private func setupViews() {
        self.view.backgroundColor = .white
        
        [launchScreenView].forEach {
            self.view.addSubview(launchScreenView)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            launchScreenView.topAnchor.constraint(equalTo: self.view.topAnchor),
            launchScreenView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            launchScreenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            launchScreenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func updateViews() {
        let launchScreenPresenter = LaunchScreenPresenter(launchScreenView: launchScreenView)
        coordinator.presenters = [launchScreenPresenter]
    }
    
}

// MARK: Private Functions

extension LaunchScreenViewController {
    
    private func presentMainApp() {
        let listCoordinator = DealsListDependencyInjector().setupDealsListDependencies()
        let listVC = listCoordinator.viewController
        self.transitionToViewController(listVC)
    }
    
}
