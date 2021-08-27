//
//  DealsListDependencyInjector.swift
//  ProductViewer
//
//  Created by David Truong on 8/26/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Domain
import DataSource

final class DealsListDependencyInjector {
    
    func setupDealsListDependencies() -> ListCoordinator {
        let dealsListRemoteDataSource = DealsListRemoteDataSource(baseApiUrl: Configuration.baseApiUrl)
        let dealsListDataRepository = DealsListDataRepository(dealsListRemoteDataSource: dealsListRemoteDataSource)
        let productListInteractor = ProductListInteractor(productListDomainDataSourceInterface: dealsListDataRepository)
        let listCoordinator = ListCoordinator(productListInteractor)
        return listCoordinator
    }
    
}
