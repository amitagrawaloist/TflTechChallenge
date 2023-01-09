//
//  APIError.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation

enum APIError: Error {
    case noNetwork
    case invalidURL
    case responseError
    case unknown
    case noError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return Constants.ErrorMessages.invalidURL
        case .responseError:
            return Constants.ErrorMessages.invalidResponse
        case .unknown:
            return Constants.ErrorMessages.unknownError
        case .noNetwork:
            return Constants.ErrorMessages.noInternetConnection
        case .noError:
            return Constants.ErrorMessages.noError
        }
    }
}

