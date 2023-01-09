//
//  RoadStatusService.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation

enum RoadStatusApi {
    case list
    case invalid
    var apiURL: String {
        switch self {
        case .list:
            return Constants.URLs.baseURL + Constants.URLs.roadStatusEndpoints
        case .invalid:
            return Constants.URLs.baseURL
        }
    }
}

protocol RoadStatusServiceProtocol {
    func getRoadStatusData(api: RoadStatusApi, roadName: String) async throws -> RoadStatusResponse
}

class RoadStatusDataService: RoadStatusServiceProtocol {
        
    private var networkManager: NetworkManagerProtocol
    
    init(withNetworkManager: NetworkManagerProtocol) {
        self.networkManager = withNetworkManager
    }
    
    
    func getRoadStatusData(api: RoadStatusApi, roadName: String) async throws -> RoadStatusResponse {
        do {
            //MARK: Check if api url is correct
            let url = try createRoadStatusURL(api: api, roadName: roadName)
            
            let (responseData, urlResponse) = try await self.networkManager.initiateServiceRequest(url: url)
            do{
                let roadStatusData = try self.parseServerResponseData(serverResponseData: responseData, statusCode: (urlResponse as? HTTPURLResponse)?.statusCode)
                return roadStatusData
            } catch{
                throw APIError.responseError
            }
        } catch {
            throw error
        }
    }
    
    private func createRoadStatusURL(api: RoadStatusApi, roadName: String) throws -> URL {
        guard var components = URLComponents(string: api.apiURL) else {
            throw APIError.invalidURL
        }
        
        components.path.append(roadName)
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        return url
    }
        
    private func parseServerResponseData(serverResponseData: Data?, statusCode: Int?) throws -> RoadStatusResponse {
        guard let data = serverResponseData
        else {  throw APIError.responseError }
        do {
            switch statusCode {
            case 200:
                let roadStatusData = try JSONDecoder().decode([RoadStatusSuccess].self, from: data)
                let roadStatusResponse = RoadStatusResponse(statusCode: statusCode!, successResponse: roadStatusData, failureResponse: nil)
                return roadStatusResponse
            case 404:
                let roadStatusData = try JSONDecoder().decode(RoadStatusFailure.self, from: data)
                let roadStatusResponse = RoadStatusResponse(statusCode: statusCode!, successResponse: nil, failureResponse: roadStatusData)
                return roadStatusResponse
            default:
                throw APIError.responseError
            }
        } catch {
            throw APIError.responseError
        }
    }
    
}
