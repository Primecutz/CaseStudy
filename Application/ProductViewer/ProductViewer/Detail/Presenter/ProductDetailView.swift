//
//  ProductDetailView.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

class ProductDetailView: UIView {
    
    // Class Properties
    private var item: DetailItemViewState?
    
    // Delegate Properties
    weak var delegate: ProductDetailViewDelegate?

    // View Properties
    private lazy var backgroundScrollView: UIScrollView = {
        let backgroundScrollView = UIScrollView()
        backgroundScrollView.alwaysBounceVertical = true
        return backgroundScrollView
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        productImageView.contentMode = .scaleAspectFill
        return productImageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = .boldSystemFont(ofSize: 24)
        priceLabel.textColor = .targetJetBlackColor
        priceLabel.adjustsFontSizeToFitWidth = true
        return priceLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .targetJetBlackColor
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .targetJetBlackColor
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private lazy var addToCartButton: UIButton = {
        let addToCartButton = UIButton(type: .system)
        addToCartButton.backgroundColor = .targetBullseyeRedColor
        addToCartButton.setTitle("add to cart", for: .normal)
        addToCartButton.setTitleColor(.targetStarkWhiteColor, for: .normal)
        addToCartButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonPressed), for: .touchUpInside)
        addToCartButton.layer.cornerRadius = 5
        return addToCartButton
    }()
    
    private lazy var addToListButton: UIButton = {
        let addToListButton = UIButton(type: .system)
        addToListButton.backgroundColor = .targetStrokeGrayColor
        addToListButton.setTitle("add to list", for: .normal)
        addToListButton.setTitleColor(.targetJetBlackColor, for: .normal)
        addToListButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        addToListButton.addTarget(self, action: #selector(addToListButtonPressed), for: .touchUpInside)
        addToListButton.layer.cornerRadius = 5
        return addToListButton
    }()
    
    // Constraint Properties
    private let buttonHeightConstant: CGFloat = 40

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

extension ProductDetailView {

    private func setupViews() {
        self.backgroundColor = .clear
        
        backgroundScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addAndPinSubview(backgroundScrollView)
        
        [containerView].forEach {
            backgroundScrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [productImageView, priceLabel, titleLabel, descriptionLabel, addToCartButton, addToListButton].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: backgroundScrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: backgroundScrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: backgroundScrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: backgroundScrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: backgroundScrollView.widthAnchor),
            
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),

            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            descriptionLabel.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -15),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 70000),
            
            addToCartButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            addToCartButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            addToCartButton.heightAnchor.constraint(equalToConstant: buttonHeightConstant),
            
            addToListButton.topAnchor.constraint(equalTo: addToCartButton.bottomAnchor, constant: 15),
            addToListButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            addToListButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            addToListButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            addToListButton.heightAnchor.constraint(equalToConstant: buttonHeightConstant)
        ])
    }

}

// MARK: Public Functions

extension ProductDetailView {
    
    func configureView(_ viewState: DetailViewState) {
        self.item = viewState.detailItem
        priceLabel.text = viewState.detailItem.price
        titleLabel.text = viewState.detailItem.title
        descriptionLabel.text = viewState.detailItem.description
        let _ = productImageView.loadImageFrom(viewState.detailItem.imageUrl)
    }
    
}

// MARK: Private Functions

extension ProductDetailView {
    
    @objc private func addToCartButtonPressed() {
        guard let item = item else { return }
        delegate?.addItemToShippingCart(item)
    }
    
    @objc private func addToListButtonPressed() {
        guard let item = item else { return }
        delegate?.addItemToWishList(item)
    }
    
}

protocol ProductDetailViewDelegate: AnyObject {
    func addItemToShippingCart(_ item: DetailItemViewState)
    func addItemToWishList(_ item: DetailItemViewState)
}
