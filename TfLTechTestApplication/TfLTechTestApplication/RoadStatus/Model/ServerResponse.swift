//
//  ServerResponse.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation

struct RoadStatusSuccess: Codable {
    
    let id:String
    let displayName:String
    let statusSeverity:String
    let statusSeverityDescription:String
    let bounds:String
    let envelope:String
    let url:String

    enum CodingKeys: String, CodingKey {
        case id
        case displayName
        case statusSeverity
        case statusSeverityDescription
        case bounds
        case envelope
        case url
    }
}

struct RoadStatusFailure: Codable {
    
    let message:String

    enum CodingKeys: String, CodingKey {
        case message
    }
}

struct RoadStatusResponse {
    
    let statusCode:Int
    let successResponse:[RoadStatusSuccess]?
    let failureResponse:RoadStatusFailure?
}
