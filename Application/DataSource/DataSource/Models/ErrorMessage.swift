//
//  ErrorMessage.swift
//  DataSource
//
//  Created by David Truong on 8/26/21.
//

import Foundation
import Domain

public struct ErrorMessage: Error {
    
    public let message: String
    
    public init(_ message: String) {
        self.message = message
    }
    
    public init(_ message: CustomErrorMessage) {
        self.message = message.rawValue
    }
    
    func transferToErrorMessageEntity() -> ErrorMessageEntity {
        let errorMessageEntity = ErrorMessageEntity(message)
        return errorMessageEntity
    }
    
}

public enum CustomErrorMessage: String {
    case badUrl = "Bad API URL"
    case badData = "Error Converting JSON Data"
    case noInternet = "No Internet Connection"
}
