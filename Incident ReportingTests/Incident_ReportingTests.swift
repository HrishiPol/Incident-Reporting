//
//  Incident_ReportingTests.swift
//  Incident ReportingTests
//
//  Created by Hrishikesh Pol on 17/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import XCTest
@testable import Incident_Reporting

class Incident_ReportingTests: XCTestCase {
    
    var incidentViewModel: IncidentViewModel?

    override func setUpWithError() throws {
        super.setUp()
        incidentViewModel = IncidentViewModel.init()
    }

    override func tearDownWithError() throws {
        incidentViewModel = nil
        super.tearDown()
    }
    
    func saveDataIntoDatabase() {
        incidentViewModel?.submit("MachineTest", "Singapore", "There is a fault in the machine", "2020-06-19 09:00:00", completionHandler: { (error) in })
    }
    
    func testIncidentDataSaveInLocalDatabase() {
        XCTAssertNotNil(incidentViewModel)
        saveDataIntoDatabase()
        let item = incidentViewModel?.getIncidentReportsList()
        XCTAssertNotNil(item)
        XCTAssertTrue(item?.count ?? 0 > 0)
    }
    
    func testSearchItemFromLocalDatabase() {
        XCTAssertNotNil(incidentViewModel)
        saveDataIntoDatabase()
        let item = incidentViewModel?.searchIncident(byMachineName: "Test")
        XCTAssertNotNil(item)
        XCTAssertTrue(item?.count ?? 0 > 0)
        let firstIncident = item?.first
        XCTAssertNotNil(firstIncident)
        XCTAssertTrue(firstIncident?.incidentID.isEmpty == false)
        XCTAssertTrue(firstIncident?.machineName.isEmpty == false)
        XCTAssertTrue(firstIncident?.locationName.isEmpty == false)
        XCTAssertTrue(firstIncident?.timeStamp.isEmpty == false)
        XCTAssertTrue(firstIncident?.description.isEmpty == false)
        XCTAssertTrue(firstIncident?.locationName == "Singapore")
    }
}
