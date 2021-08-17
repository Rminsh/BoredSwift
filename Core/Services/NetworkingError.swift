//
//  NetworkingError.swift
//  Core
//
//  Created by armin on 8/1/21.
//

import Foundation

enum NetworkingError: Error {
    case badNetworkingRequest
    case errorParse
    case unexpectedError
}

extension NetworkingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badNetworkingRequest:
            return NSLocalizedString("Network error", comment: "")
        case .errorParse:
            return NSLocalizedString("Parsing error", comment: "")
        case .unexpectedError:
            return NSLocalizedString("Unexpected network error", comment: "")
        }
    }
}

extension NetworkingError: Identifiable {
    var id: String? {
        errorDescription
    }
}
