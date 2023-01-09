//
//  StubGenerator.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 08/01/2023.
//

import Foundation

class StubGenerator {
    static func stubRoadStatusSuccess() throws -> RoadStatusResponse {
        guard  let path = Bundle.main.path(forResource: "RoadStatusSuccessData", ofType: "json")
        else {
            throw APIError.unknown
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let roadStatusData = try JSONDecoder().decode([RoadStatusSuccess].self, from: data)
            let roadStatusResponse = RoadStatusResponse(statusCode: 200, successResponse: roadStatusData, failureResponse: nil)
            return roadStatusResponse
        } catch {
            throw APIError.unknown
        }
    }
    
    static func stubRoadStatusSuccessResponseData() throws -> Data {
        guard  let path = Bundle.main.path(forResource: "RoadStatusSuccessData", ofType: "json")
        else {
            throw APIError.unknown
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            throw APIError.unknown
        }
    }
    
    static func stubRoadStatusFailure() throws -> RoadStatusResponse {
        guard  let path = Bundle.main.path(forResource: "RoadStatusFailureData", ofType: "json")
        else {
            throw APIError.unknown
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let roadStatusData = try JSONDecoder().decode(RoadStatusFailure.self, from: data)
            let roadStatusResponse = RoadStatusResponse(statusCode: 200, successResponse: nil, failureResponse: roadStatusData)
            return roadStatusResponse
        } catch {
            throw APIError.unknown
        }
    }
    
    static func stubRoadStatusFailureResponseData() throws -> Data {
        guard  let path = Bundle.main.path(forResource: "RoadStatusFailureData", ofType: "json")
        else {
            throw APIError.unknown
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            throw APIError.unknown
        }
    }
}
