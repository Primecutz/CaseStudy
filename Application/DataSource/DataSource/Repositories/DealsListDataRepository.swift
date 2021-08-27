//
//  DealsListDataRepository.swift
//  DataSource
//
//  Created by David Truong on 8/26/21.
//

import Foundation
import Domain

public class DealsListDataRepository: ProductListDomainDataSourceInterface {
    
    let dealsListRemoteDataSource: DealsListRemoteDataSourceInterface
    
    public init(dealsListRemoteDataSource: DealsListRemoteDataSourceInterface) {
        self.dealsListRemoteDataSource = dealsListRemoteDataSource
    }
    
    public func execute(fetch completion: @escaping ProductsHandler) {
        dealsListRemoteDataSource.fetchDealsList { result in
            switch result {
            case .success(let products):
                var productEntities: [ProductEntity] = []
                if let products = products {
                    productEntities = products.compactMap { return $0.transferToProductEntity() }
                }
                completion(.success(productEntities))
            case .failure(let errorMessage):
                let errorMessageEntity = errorMessage.transferToErrorMessageEntity()
                completion(.failure(errorMessageEntity))
            }
        }
    }
    
}
