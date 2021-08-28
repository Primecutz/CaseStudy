//
//  DealsDetailDependencyInjector.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Domain
import DataSource

class DealsDetailDependencyInjector {
    
    func setupDealsDetailDependencies() -> DetailCoordinator {
        let dealsDetailRemoteDataSource = DealsDetailRemoteDataSource(baseApiUrl: Configuration.baseApiUrl)
        let dealsDetailDataRepository = DealsDetailDataRepository(dealsDetailRemoteDataSource: dealsDetailRemoteDataSource)
        let productDetailInteractor = ProductDetailInteractor(productDetailDomainDataSourceInterface: dealsDetailDataRepository)
        let detailCoordinator = DetailCoordinator(productDetailInteractor: productDetailInteractor)
        return detailCoordinator
    }
    
}
