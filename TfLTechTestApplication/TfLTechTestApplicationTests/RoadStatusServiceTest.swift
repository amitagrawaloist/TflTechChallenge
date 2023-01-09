//
//  RoadStatusServiceTest.swift
//  TfLTechTestApplicationTests
//
//  Created by Amit Agrawal on 08/01/2023.
//

import XCTest

@testable import TfLTechTestApplication

final class RoadStatusServiceTest: XCTestCase {

    var sut: RoadStatusDataService!
    
    override func setUpWithError() throws {
        super.setUp()
        let mockNetworkManager = MockNetworkManager()
        
        sut = RoadStatusDataService(withNetworkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testGetRoadStatusDataFunctionForSuccessResponse() {
        let expect = XCTestExpectation(description: "road status detail screen will be shown")
        Task{[weak self] in
            let data = try await self?.sut?.getRoadStatusData(api:.list, roadName: "A2")
            expect.fulfill()
            XCTAssertNotNil(data)
            wait(for: [expect], timeout: 5.0)
        }
    }
    
    func testGetRoadStatusDataFunctionForErrorResponse() {
        let expect = XCTestExpectation(description: "road not found error response")

        Task{[weak self] in
            do {
                let _ = try await self?.sut?.getRoadStatusData(api: .invalid, roadName: "A23333")
            expect.fulfill()
            } catch {
                XCTAssertNotNil(error)
            }
            wait(for: [expect], timeout: 3.0)
        }
    }

}
