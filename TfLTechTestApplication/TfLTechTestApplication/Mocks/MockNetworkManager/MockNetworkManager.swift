//
//  MockNetworkManager.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 08/01/2023.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    func initiateServiceRequest(url: URL) async throws -> (Data, URLResponse) {
        do {
            let responseData = try StubGenerator.stubRoadStatusSuccessResponseData()
            return (responseData, URLResponse())
        } catch {
            throw APIError.responseError
        }
    }
}
