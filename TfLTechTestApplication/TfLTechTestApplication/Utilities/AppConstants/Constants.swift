//
//  Constants.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation

struct Constants {
    struct Texts {
        static let roadStatusTitle = "TfL Road Status"
        static let alertOkTitle = "Ok"
        static let alertCancelTitle = "Cancel"
        static let alertQuitTitle = "Quit"
    }
    
    struct URLs {
        static let baseURL = "https://api.tfl.gov.uk"        
        static let roadStatusEndpoints = "/Road/?app_key=\(APIKey.primaryKey)"
    }
    
    struct StoryboardXIBNames {
        static let main = "Main"
        static let roadStatusViewController = "RoadStatusViewController"
    }
    
    struct Value {
        static let tableRowEstimatedHeight = 90.0
    }
  
    struct ErrorMessages {
        static let xibNotFound = "xib does not exists"
        static let invalidURL = "Invalid URL"
        static let invalidResponse = "Invalid response"
        static let unknownError = "Unknown error"
        static let noInternetConnection = "No internet connection"
        static let noError = "No Error"
        static let jailbrokenDevice = "This Device is JailBroken.Please quit the application."
    }
    
    struct APIKey {
        static let primaryKey = ""
        static let secondaryKey = ""
    }
}

