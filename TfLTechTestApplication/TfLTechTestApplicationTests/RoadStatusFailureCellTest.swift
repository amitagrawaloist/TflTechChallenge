//
//  RoadStatusFailureCellTest.swift
//  TfLTechTestApplicationTests
//
//  Created by Amit Agrawal on 08/01/2023.
//

import Foundation
import XCTest

@testable import TfLTechTestApplication

final class RoadStatusFailureCellTest: XCTestCase {

    var sut: RoadStatusFailureCell!
    let tableView = UITableView()
    
    override func setUpWithError() throws {
        super.setUp()
                
        tableView.register(RoadStatusFailureCell.nib, forCellReuseIdentifier: RoadStatusFailureCell.identifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoadStatusFailureCell.identifier, for: IndexPath.init(row: 0, section: 0)) as? RoadStatusFailureCell
        else { fatalError(Constants.ErrorMessages.xibNotFound) }
        sut = cell
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testCellUpdateProperties() {
        // Given
        let vm = RoadStatusFailureCellViewModel(message: "The following road id is not recognised: A2343434")
        let expect = XCTestExpectation(description: "cell properties set")
        sut.cellViewModel = vm
        sut.updateCellProperties(cellViewModel: vm)
        expect.fulfill()
        wait(for: [expect], timeout: 3.0)
        XCTAssertEqual(sut.cellViewModel?.message, "The following road id is not recognised: A2343434")
    }

}
