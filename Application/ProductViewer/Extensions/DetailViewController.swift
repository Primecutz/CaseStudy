//
//  DetailViewController.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

class DetailViewController: UIViewController {
    
    // Class Properties
    private var coordinator: TempoCoordinator
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> DetailViewController {
        let viewController = DetailViewController(coordinator: coordinator)
        return viewController
    }
    
    // View Properties
    private lazy var detailView: ProductDetailView = {
        let detailView = ProductDetailView()
        return detailView
    }()
    
    // View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
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

extension DetailViewController {
    
    private func setupViews() {
        self.view.backgroundColor = .targetStarkWhiteColor
        
        detailView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addAndPinSubview(detailView)
    }
    
    private func updateViews() {
        let productDetailPresenter = ProductDetailPresenter(productDetailView: detailView, dispatcher: coordinator.dispatcher)
        coordinator.presenters = [productDetailPresenter]
    }
    
}
