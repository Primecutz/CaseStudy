//
//  ProductDetailInteractor.swift
//  Domain
//
//  Created by David Truong on 8/26/21.
//

import Foundation

public class ProductDetailInteractor: ProductDetailInteractorInterface {
    
    let productDetailDomainDataSourceInterface: ProductDetailDomainDataSourceInterface
    
    public init(productDetailDomainDataSourceInterface: ProductDetailDomainDataSourceInterface) {
        self.productDetailDomainDataSourceInterface = productDetailDomainDataSourceInterface
    }
    
    public func execute(fetch completion: @escaping ProductHandler) {
        productDetailDomainDataSourceInterface.execute(fetch: { result in
            switch result {
            case .success(let productEntity):
                completion(.success(productEntity))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}

public protocol ProductDetailInteractorInterface {
    typealias ProductHandler = (Result<ProductEntity, Error>) -> Void
    func execute(fetch completion: @escaping ProductHandler)
}

public protocol ProductDetailDomainDataSourceInterface {
    typealias ProductHandler = (Result<ProductEntity, Error>) -> Void
    func execute(fetch completion: @escaping ProductHandler)
}
