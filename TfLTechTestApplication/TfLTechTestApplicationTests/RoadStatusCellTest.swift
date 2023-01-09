//
//  RoadStatusCellTest.swift
//  TfLTechTestApplicationTests
//
//  Created by Amit Agrawal on 08/01/2023.
//

import Foundation
import XCTest

@testable import TfLTechTestApplication

final class RoadStatusCellTest: XCTestCase {

    var sut: RoadStatusCell!
    let tableView = UITableView()
    
    override func setUpWithError() throws {
        super.setUp()
        tableView.register(RoadStatusCell.nib, forCellReuseIdentifier: RoadStatusCell.identifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoadStatusCell.identifier, for: IndexPath.init(row: 0, section: 0)) as? RoadStatusCell
        else { fatalError(Constants.ErrorMessages.xibNotFound) }
        sut = cell
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testCellUpdateProperties() {
        // Given
        let vm = RoadStatusCellViewModel(displayName: "A2", statusSeverity: "Good", statusSeverityDescription: "No Exceptional Delays")
        let expect = XCTestExpectation(description: "cell properties set")
        sut.cellViewModel = vm
        sut.updateCellProperties(cellViewModel: vm)
        expect.fulfill()
        wait(for: [expect], timeout: 3.0)
        XCTAssertEqual(sut.cellViewModel?.displayName, "A2")
    }

}
