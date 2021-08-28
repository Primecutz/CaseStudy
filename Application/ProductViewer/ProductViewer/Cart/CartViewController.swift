//
//  CartViewController.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

class CartViewController: UIViewController {
    
    // Class Properties
    private var coordinator: TempoCoordinator
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> ListViewController {
        let viewController = ListViewController(coordinator: coordinator)
        return viewController
    }
    
    // View Properties
    private lazy var titleImageView: UIImageView = {
        let titleImageView = UIImageView(image: .targetBrand)
        titleImageView.contentMode = .scaleAspectFit
        return titleImageView
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .targetStrokeGrayColor
        return lineView
    }()
    
    private lazy var listCollectionView: UICollectionView = {
        let harmonyLayout = HarmonyLayout()
        harmonyLayout.collectionViewMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .narrow, left: .none)
        harmonyLayout.defaultSectionMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .none, left: .none)
        let listCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: harmonyLayout)
        listCollectionView.backgroundColor = .targetFadeAwayGrayColor
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        listCollectionView.alwaysBounceVertical = true
        listCollectionView.contentInset = .zero //UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        return listCollectionView
    }()
    
    // View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
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

extension CartViewController {
    
    private func setupViews() {
        self.navigationController?.navigationBar.tintColor = .targetJetBlackColor
        self.navigationController?.navigationBar.barTintColor = .targetStarkWhiteColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = .targetStarkWhiteColor
        self.view.addAndPinSubview(listCollectionView)
        
        [titleImageView, lineView].forEach {
            self.navigationController?.navigationBar.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        if let navigationBar = self.navigationController?.navigationBar {
            NSLayoutConstraint.activate([
                titleImageView.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 5),
                titleImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -5),
                titleImageView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
                
                lineView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                lineView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
                lineView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
                lineView.heightAnchor.constraint(equalToConstant: 1)
            ])
        }
    }
    
    private func updateViews() {
        let components: [ComponentType] = [ProductListComponent()]
        let componentProvider = ComponentProvider(components: components, dispatcher: coordinator.dispatcher)
        let collectionViewAdapter = CollectionViewAdapter(collectionView: listCollectionView, componentProvider: componentProvider)
        let sectionPresenter = SectionPresenter(adapter: collectionViewAdapter)
        coordinator.presenters = [sectionPresenter]
    }
    
}
