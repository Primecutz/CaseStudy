//
//  MainTabBarController.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // Class Properties
    let listCoordinator = DealsListDependencyInjector().setupDealsListDependencies()
    let cartCoordinator = CartCoordinator()
    
    // View Properties
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .targetStrokeGrayColor
        return lineView
    }()
    
    // View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTabs()
    }

}

// MARK: Setup Tabs

extension MainTabBarController {
    
    private func setupViews() {
        self.delegate = self
        self.tabBar.tintColor = .targetBullseyeRedColor
        self.tabBar.unselectedItemTintColor = .targetNeutralGrayColor
        self.tabBar.barTintColor = .targetStarkWhiteColor
        self.tabBar.barStyle = .default
        self.tabBar.isTranslucent = true
        
        [lineView].forEach {
            self.tabBar.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: self.tabBar.topAnchor),
            lineView.leadingAnchor.constraint(equalTo: self.tabBar.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.tabBar.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupTabs() {
        let listVC = listCoordinator.viewController
        let listNC = UINavigationController(rootViewController: listVC)
        listNC.tabBarItem = UITabBarItem(title: "Deals", image: .dealsTab, selectedImage: .dealsTab)
        
        let cartVC = cartCoordinator.viewController
        let cartNC = UINavigationController(rootViewController: cartVC)
        cartNC.tabBarItem = UITabBarItem(title: "Cart", image: .cartTab, selectedImage: .cartTab)
 
        self.viewControllers = [listNC, cartNC]
    }
    
}

// MARK: UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard tabBarController.selectedIndex == TabBarIndex.cart else { return }
        cartCoordinator.updateState()
    }
    
}
