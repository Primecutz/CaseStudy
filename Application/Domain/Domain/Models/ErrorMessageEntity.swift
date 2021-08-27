//
//  ErrorMessageEntity.swift
//  Domain
//
//  Created by David Truong on 8/26/21.
//

import Foundation

public struct ErrorMessageEntity: Error {
    
    public let message: String
    
    public init(_ message: String) {
        self.message = message
    }
    
}
