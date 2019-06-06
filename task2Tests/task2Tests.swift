//
//  task2Tests.swift
//  task2Tests
//
//  Created by Anton on 6/6/19.
//  Copyright © 2019 mac. All rights reserved.
//

import XCTest
@testable import task2

class task2Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeather() {
        WeatherGetter.getTemperature(latitude: 54.298483, longitude: 27.533342, completition: checkTemp, completition2: checkCond)
    }
    
    func checkTemp(temperature: Double) {
        print("Temperature = \(temperature)")
    }
    
    func checkCond(condition: String) {
        print("Condition = \(condition)")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
