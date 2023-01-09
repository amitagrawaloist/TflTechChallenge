//
//  UIDeviceJailbrokenTest.swift
//  TfLTechTestApplicationTests
//
//  Created by Amit Agrawal on 08/01/2023.
//

import Foundation
import XCTest

@testable import TfLTechTestApplication

final class UIDeviceJailbrokenTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIFDeviceIsJailBroken() {
        // Given
        var isDeviceJailBreak = false
        let expect = XCTestExpectation(description: "Device is jailbroken")
        // When
         isDeviceJailBreak = UIDevice.current.checkisDeviceJailBrocken()
        expect.fulfill()
        // Then
        wait(for: [expect], timeout: 5.0)
        XCTAssertFalse(isDeviceJailBreak)
    }

}
