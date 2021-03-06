//
//  ProductListView.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

class ProductListView: UIView {
    
    // Class Properties
    private var item: ListItemViewState?
    private var imageDownloadTask: URLSessionDataTask?
    
    // Delegate Properties
    weak var delegate: ProductListViewDelegate?

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
    
    private lazy var shipButton: UIButton = {
        let shipButton = UIButton(type: .system)
        shipButton.setTitle("ship", for: .normal)
        shipButton.setTitleColor(.targetJetBlackColor, for: .normal)
        shipButton.titleLabel?.font = .systemFont(ofSize: 18)
        shipButton.addTarget(self, action: #selector(shipButtonPressed), for: .touchUpInside)
        shipButton.contentHorizontalAlignment = .right
        return shipButton
    }()
    
    private lazy var orLabel: UILabel = {
        let orLabel = UILabel()
        orLabel.text = "or"
        orLabel.font = .systemFont(ofSize: 20)
        orLabel.textColor = .targetStrokeGrayColor
        return orLabel
    }()
    
    private lazy var b2Button: UIButton = {
        let b2Button = UIButton(type: .system)
        b2Button.setTitle("B2", for: .normal)
        b2Button.setTitleColor(.targetBullseyeRedColor, for: .normal)
        b2Button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        b2Button.addTarget(self, action: #selector(b2ButtonPressed), for: .touchUpInside)
        b2Button.layer.cornerRadius = buttonHeightConstant / 2
        b2Button.layer.borderColor = UIColor.targetStrokeGrayColor.cgColor
        b2Button.layer.borderWidth = 2
        return b2Button
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

extension ProductListView {

    private func setupViews() {
        self.backgroundColor = .clear
        
        [containerView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [productImageView, titleLabel, dividerLineView, priceLabel, shipButton, orLabel, b2Button].forEach {
            containerView.addSubview($0)
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
            priceLabel.trailingAnchor.constraint(equalTo: shipButton.leadingAnchor, constant: -15),
            
            shipButton.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            shipButton.heightAnchor.constraint(equalToConstant: buttonHeightConstant),
            shipButton.widthAnchor.constraint(equalTo: shipButton.heightAnchor),
            
            orLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            orLabel.leadingAnchor.constraint(equalTo: shipButton.trailingAnchor, constant: 5),
            orLabel.widthAnchor.constraint(equalToConstant: 20),
            
            b2Button.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            b2Button.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 5),
            b2Button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            b2Button.heightAnchor.constraint(equalToConstant: buttonHeightConstant),
            b2Button.widthAnchor.constraint(equalTo: b2Button.heightAnchor)
        ])
    }

}

// MARK: Public Functions

extension ProductListView {
    
    func configureViewWithItem(_ item: ListItemViewState) {
        self.item = item
        titleLabel.text = item.title
        priceLabel.text = item.price
        imageDownloadTask = imageDownloadTask == nil ? productImageView.loadImageFrom(item.imageUrl) : nil
    }
    
}

// MARK: Private Functions

extension ProductListView {
    
    @objc private func shipButtonPressed() {
        guard let item = item else { return }
        delegate?.addItemToShippingCart(item)
    }
    
    @objc private func b2ButtonPressed() {
        guard let item = item else { return }
        delegate?.addItemToWishList(item)
    }
    
}

// MARK: ReusableView

extension ProductListView: ReusableView {
    @nonobjc static let reuseID = "ProductListViewIdentifier"
    
    @nonobjc func prepareForReuse() {
        imageDownloadTask?.cancel()
        imageDownloadTask = nil
        productImageView.image = nil
    }
}

protocol ProductListViewDelegate: AnyObject {
    func addItemToShippingCart(_ item: ListItemViewState)
    func addItemToWishList(_ item: ListItemViewState)
}
