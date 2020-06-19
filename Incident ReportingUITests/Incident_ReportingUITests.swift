//
//  Incident_ReportingUITests.swift
//  Incident ReportingUITests
//
//  Created by Hrishikesh Pol on 17/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import XCTest

class Incident_ReportingUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        super.setUp()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        XCUIApplication().terminate()
        super.tearDown()
    }

    func testApplication() throws {
        // UI tests must launch the application that they test.
        let usernameTextField = app.textFields["Username"]
        XCTAssertNotNil(usernameTextField)
        usernameTextField.tap()
        usernameTextField.typeText("testuser")
        sleep(1)
        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertNotNil(passwordTextField)
        passwordTextField.tap()
        passwordTextField.typeText("password")
        
        let loginButton = app.buttons["Login"]
        XCTAssertNotNil(loginButton)
        loginButton.tap()
        
        
        app.buttons["Report incident"].tap()
        sleep(1)
        let machineNameTextField = app.textFields["Name of faulty machine."]
        XCTAssertNotNil(machineNameTextField)
        machineNameTextField.tap()
        machineNameTextField.typeText("MachineReport123")
        
        sleep(1)
        let nameOfImpactedLocationTextField = app.textFields["Name of impacted location."]
        XCTAssertNotNil(nameOfImpactedLocationTextField)
        nameOfImpactedLocationTextField.tap()
        nameOfImpactedLocationTextField.typeText("Singapore")

        
        sleep(1)
        let descriptionTextField = app.textFields["Short description."]
        XCTAssertNotNil(descriptionTextField)
        descriptionTextField.tap()
        sleep(1)
        descriptionTextField.typeText("Description")
        descriptionTextField.typeText("\n")

        sleep(1)
        let submitButton = app.navigationBars["Report Incident"].buttons["Submit"]
        XCTAssertNotNil(submitButton)
        submitButton.tap()
        
        sleep(1)
        let viewReportsButton = app.buttons["View reports"]
        XCTAssertNotNil(viewReportsButton)
        viewReportsButton.tap()
        sleep(2)
        let backButton = app.navigationBars["Incident List"].buttons["Back"]
        backButton.tap()
    }
}
