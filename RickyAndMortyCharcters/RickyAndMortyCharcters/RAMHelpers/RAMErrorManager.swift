//
//  RAMErrorManager.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 28/10/22.
//

import Foundation


enum RAMError: Error {
    case invalidResponse(statusCode: Int)
    case serializationFailed
    case noDataReceived
}

extension RAMError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse(statusCode: let statusCode):
            return NSLocalizedString("the response is invalid with \(statusCode)", comment: "")
        case .noDataReceived:
            return NSLocalizedString("Received data is not valid", comment: "")
        case .serializationFailed:
            return NSLocalizedString("Serialisation Failed", comment: "")
        }
    }
}
