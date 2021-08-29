//
//  CartListView.swift
//  ProductViewer
//
//  Created by David Truong on 8/28/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

class CartListView: UIView {
    
    // Class Properties
    private var item: CartItemViewState?
    private var imageDownloadTask: URLSessionDataTask?
    
    // Delegate Properties
    weak var delegate: CartListViewDelegate?

    // View Properties
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor.targetStrokeGrayColor.cgColor
        containerView.layer.borderWidth = 1
        containerView.clipsToBounds = true
        return containerView
    }()
    
    private lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        productImageView.contentMode = .scaleAspectFill
        return productImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.textColor = .targetJetBlackColor
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private lazy var dividerLineView: UIView = {
        let dividerLineView = UIView()
        dividerLineView.backgroundColor = .targetStrokeGrayColor
        return dividerLineView
    }()

    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = .systemFont(ofSize: 24)
        priceLabel.textColor = .targetJetBlackColor
        priceLabel.adjustsFontSizeToFitWidth = true
        return priceLabel
    }()
    
    private lazy var quantityStackView: UIStackView = {
        let quantityStackView = UIStackView()
        quantityStackView.distribution = .fillEqually
        return quantityStackView
    }()
    
    private lazy var subtractButton: UIButton = {
        let subtractButton = UIButton(type: .system)
        subtractButton.setTitle("-", for: .normal)
        subtractButton.setTitleColor(.targetStrokeGrayColor, for: .normal)
        subtractButton.titleLabel?.font = .systemFont(ofSize: 30)
        subtractButton.addTarget(self, action: #selector(subtractButtonPressed), for: .touchUpInside)
        return subtractButton
    }()
    
    private lazy var quantityLabel: UILabel = {
        let quantityLabel = UILabel()
        quantityLabel.font = .systemFont(ofSize: 20)
        quantityLabel.textColor = .targetJetBlackColor
        quantityLabel.adjustsFontSizeToFitWidth = true
        quantityLabel.textAlignment = .center
        return quantityLabel
    }()
    
    private lazy var additionButton: UIButton = {
        let additionButton = UIButton(type: .system)
        additionButton.setTitle("+", for: .normal)
        additionButton.setTitleColor(.targetStrokeGrayColor, for: .normal)
        additionButton.titleLabel?.font = .systemFont(ofSize: 30)
        additionButton.addTarget(self, action: #selector(additionButtonPressed), for: .touchUpInside)
        return additionButton
    }()
    
    private lazy var removeButton: UIButton = {
        let removeButton = UIButton(type: .system)
        removeButton.setImage(.trash, for: .normal)
        removeButton.addTarget(self, action: #selector(removeButtonPressed), for: .touchUpInside)
        removeButton.imageEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        removeButton.layer.cornerRadius = buttonHeightConstant / 2
        removeButton.layer.borderColor = UIColor.targetBullseyeRedColor.cgColor
        removeButton.layer.borderWidth = 2
        return removeButton
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

extension CartListView {

    private func setupViews() {
        self.backgroundColor = .clear
        
        [containerView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [productImageView, titleLabel, dividerLineView, priceLabel, quantityStackView, removeButton].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [subtractButton, quantityLabel, additionButton].forEach {
            quantityStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            dividerLineView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            dividerLineView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            dividerLineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dividerLineView.heightAnchor.constraint(equalToConstant: 1),

            priceLabel.topAnchor.constraint(equalTo: containerView.centerYAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: quantityStackView.leadingAnchor, constant: -15),
            
            quantityStackView.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            quantityStackView.heightAnchor.constraint(equalToConstant: buttonHeightConstant),
            quantityStackView.widthAnchor.constraint(equalToConstant: 100),
            
            removeButton.centerYAnchor.constraint(equalTo: quantityStackView.centerYAnchor),
            removeButton.leadingAnchor.constraint(equalTo: quantityStackView.trailingAnchor, constant: 5),
            removeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            removeButton.heightAnchor.constraint(equalToConstant: buttonHeightConstant),
            removeButton.widthAnchor.constraint(equalTo: removeButton.heightAnchor)
        ])
    }

}

// MARK: Public Functions

extension CartListView {
    
    func configureViewWithItem(_ item: CartItemViewState) {
        titleLabel.text = item.title
        priceLabel.text = item.price
        updateItemQuantity(item)
        imageDownloadTask = imageDownloadTask == nil ? productImageView.loadImageFrom(item.imageUrl) : nil
    }
    
    func updateItemQuantity(_ item: CartItemViewState) {
        self.item = item
        quantityLabel.text = "\(item.quantityInCart)"
    }
    
}

// MARK: Private Functions

extension CartListView {
    
    @objc private func subtractButtonPressed() {
        guard let item = item else { return }
        delegate?.updateItemQuantity(item, view: self, add: false)
    }
    
    @objc private func additionButtonPressed() {
        guard let item = item else { return }
        delegate?.updateItemQuantity(item, view: self, add: true)
    }
    
    @objc private func removeButtonPressed() {
        guard let item = item else { return }
        delegate?.removeItemFromShippingCart(item)
    }
    
}

// MARK: ReusableView

extension CartListView: ReusableView {
    @nonobjc static let reuseID = "ProductListViewIdentifier"
    
    @nonobjc func prepareForReuse() {
        imageDownloadTask?.cancel()
        imageDownloadTask = nil
        productImageView.image = nil
    }
}

protocol CartListViewDelegate: AnyObject {
    func updateItemQuantity(_ item: CartItemViewState, view: CartListView, add: Bool)
    func removeItemFromShippingCart(_ item: CartItemViewState)
}
