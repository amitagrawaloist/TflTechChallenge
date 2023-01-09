//
//  NetworkManager.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation

enum HTTPHeaderFields: String {
    case applicationJson = "application/json"
    case applicationXMLurlencoded = "application/xml"
    case applicationContentType = "Content-Type"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkManagerProtocol {
    func initiateServiceRequest(url: URL) async throws -> (Data, URLResponse)
}

class NetworkManager: NetworkManagerProtocol {
    fileprivate func checkInternectConnectivity() throws {
        // Check if internet is available
        if !NetworkMonitor.shared.isReachable {
            throw APIError.noNetwork
        }
    }

    /// This function is responsible to initialize network call with URLSession and
    /// returns data or throw error.
    /// ```
    /// initiateServiceRequest
    /// ```
    /// - Warning: The function can throw an exception
    /// - Parameter url:  - a webservice to call with request
    /// - Returns: Data.

    func initiateServiceRequest(url: URL) async throws -> (Data, URLResponse) {
        try checkInternectConnectivity()
        
        // Set URL parameters
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        request.setValue(HTTPHeaderFields.applicationJson.rawValue,
                         forHTTPHeaderField: HTTPHeaderFields.applicationContentType.rawValue)

        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        do {
            // Call API to get data
            let (dataObj, response) = try await session.data(for: request, delegate: nil)
            guard ((response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 404) else {
                throw APIError.responseError
            }            
            return (dataObj, response)
        } catch {
            throw APIError.unknown
        }
    }
}
