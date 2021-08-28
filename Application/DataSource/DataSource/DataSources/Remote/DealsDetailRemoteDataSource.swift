//
//  DealsDetailRemoteDataSource.swift
//  DataSource
//
//  Created by David Truong on 8/26/21.
//

import Foundation

public class DealsDetailRemoteDataSource: BaseRemoteDataSource, DealsDetailRemoteDataSourceInterface {
    
    public func fetchDealsDetail(productId: Int, completion: @escaping ProductHandler) {
        let endpoint = APIEndPoint.deals + "/" + "\(productId)"
        let method = HTTPMethod.get
        standardApiRequest(baseApiUrl: baseApiUrl, endpoint: endpoint, dataDict: nil, method: method) { result in
            switch result {
            case .success((let data, let response)):
                self.standardParsedResponse(data: data, response: response) { result in
                    switch result {
                    case .success(let productDict):
                        var product: Product?
                        if let jsonData = try? JSONSerialization.data(withJSONObject: productDict, options: .prettyPrinted) {
                            //print(String(decoding: jsonData, as: UTF8.self))
                            product = try? JSONDecoder().decode(Product.self, from: jsonData)
                        }
                        completion(.success(product))
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

public protocol DealsDetailRemoteDataSourceInterface {
    typealias ProductHandler = (Result<Product?, ErrorMessage>) -> Void
    func fetchDealsDetail(productId: Int, completion: @escaping ProductHandler)
}
