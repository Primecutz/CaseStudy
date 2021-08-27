//
//  BaseRemoteDataSource.swift
//  DataSource
//
//  Created by David Truong on 8/26/21.
//

import Foundation

public class BaseRemoteDataSource: BaseRemoteDataSourceInterface {
    
    // Class Properties
    let baseApiUrl: String
    
    public init(baseApiUrl: String) {
        self.baseApiUrl = baseApiUrl
    }

}

// MARK: Public Functions

extension BaseRemoteDataSource {

    public func standardApiRequest(baseApiUrl: String, endpoint: String, dataDict: [String : Any]?, method: String, completion: @escaping RequestHandler) {
        let urlString = "\(baseApiUrl)/\(endpoint)".replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: urlString) else {
            let errorMessage = ErrorMessage(.badUrl)
            completion(.failure(errorMessage))
            return
        }
        
        var data: Data?
        if let dataDict = dataDict {
            data = try? JSONSerialization.data(withJSONObject: dataDict, options: [])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error as NSError? {
                    let errorMessage = error.code == NSURLErrorNotConnectedToInternet ? ErrorMessage(.noInternet) : ErrorMessage(error.localizedDescription)
                    completion(.failure(errorMessage))
                } else if let data = data, let response = response as? HTTPURLResponse {
                    completion(.success((data, response)))
                } else {
                    let errorMessage = ErrorMessage(.badData)
                    completion(.failure(errorMessage))
                }
            }
        }.resume()
    }

    public func standardParsedResponse(data: Data, response: HTTPURLResponse, completion: @escaping ResponseHandler) {
        let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        let dict = dataDict ?? [:]
        // if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) { print(String(decoding: jsonData, as: UTF8.self)) }
        // print("API Response: \(response.statusCode)")
        let code = dict[APIKey.errorCode] as? String ?? ""
        let message = dict[APIKey.errorMessage] as? String ?? ""
        let errorMessage = ErrorMessage(message)
        let isSuccess = response.statusCode == 200 && code.isEmpty && message.isEmpty
        isSuccess ? completion(.success(dict)) : completion(.failure(errorMessage))
    }

}

public protocol BaseRemoteDataSourceInterface {
    typealias RequestHandler = (Result<(Data, HTTPURLResponse), ErrorMessage>) -> Void
    typealias ResponseHandler = (Result<[String: Any], ErrorMessage>) -> Void
    func standardApiRequest(baseApiUrl: String, endpoint: String, dataDict: [String: Any]?, method: String, completion: @escaping RequestHandler)
    func standardParsedResponse(data: Data, response: HTTPURLResponse, completion: @escaping ResponseHandler)
}
