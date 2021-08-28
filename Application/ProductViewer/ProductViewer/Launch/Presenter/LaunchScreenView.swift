//
//  LaunchScreenView.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

class LaunchScreenView: UIView {

    // View Properties
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    // Object Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: Setup Views

extension LaunchScreenView {

    private func setupViews() {
        self.backgroundColor = .clear
        
        [logoImageView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor)
        ])
    }

}

// MARK: Public Functions

extension LaunchScreenView {
    
    func configureView(_ viewState: LaunchScreenViewState) {
        logoImageView.image = viewState.launchScreenItem.image
    }
    
}
