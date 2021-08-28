//
//  ListViewController.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

class ListViewController: UIViewController {
    
    // Class Properties
    private var coordinator: TempoCoordinator
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> ListViewController {
        let viewController = ListViewController(coordinator: coordinator)
        return viewController
    }
    
    // View Properties
    private lazy var listCollectionView: UICollectionView = {
        let harmonyLayout = HarmonyLayout()
        harmonyLayout.collectionViewMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .narrow, left: .none)
        harmonyLayout.defaultSectionMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .none, left: .none)
        let listCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: harmonyLayout)
        listCollectionView.backgroundColor = .targetFadeAwayGrayColor
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        listCollectionView.alwaysBounceVertical = true
        listCollectionView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        return listCollectionView
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

extension ListViewController {
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addAndPinSubview(listCollectionView)
    }
    
    private func updateViews() {
        let components: [ComponentType] = [ProductListComponent()]
        let componentProvider = ComponentProvider(components: components, dispatcher: coordinator.dispatcher)
        let collectionViewAdapter = CollectionViewAdapter(collectionView: listCollectionView, componentProvider: componentProvider)
        let sectionPresenter = SectionPresenter(adapter: collectionViewAdapter)
        coordinator.presenters = [sectionPresenter]
    }
    
}

