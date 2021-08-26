//
//  ProductListInteractor.swift
//  Domain
//
//  Created by David Truong on 8/26/21.
//

import Foundation

public class ProductListInteractor: ProductListInteractorInterface {
    
    let productListDomainDataSourceInterface: ProductListDomainDataSourceInterface
    
    public init(productListDomainDataSourceInterface: ProductListDomainDataSourceInterface) {
        self.productListDomainDataSourceInterface = productListDomainDataSourceInterface
    }
    
    public func execute(fetch completion: @escaping ProductsHandler) {
        productListDomainDataSourceInterface.execute(fetch: { result in
            switch result {
            case .success(let productEntities):
                completion(.success(productEntities))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}

public protocol ProductListInteractorInterface {
    typealias ProductsHandler = (Result<[ProductEntity], Error>) -> Void
    func execute(fetch completion: @escaping ProductsHandler)
}

public protocol ProductListDomainDataSourceInterface {
    typealias ProductsHandler = (Result<[ProductEntity], Error>) -> Void
    func execute(fetch completion: @escaping ProductsHandler)
}
