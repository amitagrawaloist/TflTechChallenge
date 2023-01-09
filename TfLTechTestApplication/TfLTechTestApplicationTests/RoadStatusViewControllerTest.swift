//
//  RoadStatusViewControllerTest.swift
//  TfLTechTestApplicationTests
//
//  Created by Amit Agrawal on 08/01/2023.
//

import Foundation
import XCTest

@testable import TfLTechTestApplication

final class RoadStatusViewControllerTest: XCTestCase {

    var sut: RoadStatusViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: Constants.StoryboardXIBNames.main, bundle: nil)
        let roadStatusView = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardXIBNames.roadStatusViewController) as? RoadStatusViewController
        sut = roadStatusView
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testIsNavigationTitleCorrect() {
        let _ = sut.view
        XCTAssertEqual(sut.navigationItem.title, Constants.Texts.roadStatusTitle)
    }
}
