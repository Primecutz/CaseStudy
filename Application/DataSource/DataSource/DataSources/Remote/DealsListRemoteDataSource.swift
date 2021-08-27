//
//  DealsListRemoteDataSource.swift
//  DataSource
//
//  Created by David Truong on 8/26/21.
//

import Foundation

public class DealsListRemoteDataSource: BaseRemoteDataSource, DealsListRemoteDataSourceInterface {
    
    public func fetchDealsList(completion: @escaping ProductsHandler) {
        let endpoint = APIEndPoint.deals
        let method = HTTPMethod.get
        standardApiRequest(baseApiUrl: baseApiUrl, endpoint: endpoint, dataDict: nil, method: method) { result in
            switch result {
            case .success((let data, let response)):
                self.standardParsedResponse(data: data, response: response) { result in
                    switch result {
                    case .success(let dataDict):
                        var products: [Product]?
                        if let productDicts = dataDict[APIKey.products] as? [[String: Any]] {
                            if let jsonData = try? JSONSerialization.data(withJSONObject: productDicts, options: .prettyPrinted) {
                                //print(String(decoding: jsonData, as: UTF8.self))
                                products = try? JSONDecoder().decode([Product].self, from: jsonData)
                            }
                        }
                        completion(.success(products))
                    case .failure(let errorMessage):
                        completion(.failure(errorMessage))
                    }
                }
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
}

public protocol DealsListRemoteDataSourceInterface {
    typealias ProductsHandler = (Result<[Product]?, ErrorMessage>) -> Void
    func fetchDealsList(completion: @escaping ProductsHandler)
}
