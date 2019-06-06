//
//  task2UITests.swift
//  task2UITests
//
//  Created by Anton on 6/6/19.
//  Copyright © 2019 mac. All rights reserved.
//

import XCTest

class task2UITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() {
        let app = XCUIApplication()
        app.segmentedControls.element.buttons["Register"].tap()
        app.textFields["login"].tap()
        app.textFields["login"].typeText("test")
        app.textFields["password"].tap()
        app.textFields["password"].typeText("test")
        app.textFields["confirm"].tap()
        app.textFields["confirm"].typeText("test")
        app.buttons["logger"].tap()
        app.segmentedControls.element.buttons["Login"].tap()
        app.buttons["logger"].tap()
    }

}
