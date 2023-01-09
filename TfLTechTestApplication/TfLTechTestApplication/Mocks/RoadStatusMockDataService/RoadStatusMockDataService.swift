//
//  RoadStatusMockDataService.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 08/01/2023.
//

import Foundation

enum ResponseType {
    case success
    case error
}

class RoadStatusMockDataService: RoadStatusServiceProtocol {
    
    var responseType: ResponseType = .success
    
    func getRoadStatusData(api: RoadStatusApi, roadName: String) async throws -> RoadStatusResponse {
        switch responseType {
        case .success:
            if !(NetworkMonitor.shared.isReachable) {
                throw APIError.noNetwork
            }
            if api == .invalid {
                throw APIError.unknown
            }
            do {
                let roadStatusArray = try StubGenerator.stubRoadStatusSuccess()
                return roadStatusArray
            } catch {
                throw error
            }
        case .error :
            throw APIError.responseError
        }
    }
}
