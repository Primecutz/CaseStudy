//
//  DealsDetailDataRepository.swift
//  DataSource
//
//  Created by David Truong on 8/26/21.
//

import Foundation
import Domain

public class DealsDetailDataRepository: ProductDetailDomainDataSourceInterface {
    
    let dealsDetailRemoteDataSource: DealsDetailRemoteDataSourceInterface
    
    public init(dealsDetailRemoteDataSource: DealsDetailRemoteDataSourceInterface) {
        self.dealsDetailRemoteDataSource = dealsDetailRemoteDataSource
    }
    
    public func execute(fetchProduct id: Int, completion: @escaping ProductHandler) {
        dealsDetailRemoteDataSource.fetchDealsDetail(productId: id) { result in
            switch result {
            case .success(let product):
                let productEntity = product?.transferToProductEntity()
                completion(.success(productEntity))
            case .failure(let errorMessage):
                let errorMessageEntity = errorMessage.transferToErrorMessageEntity()
                completion(.failure(errorMessageEntity))
            }
        }
    }
    
}
