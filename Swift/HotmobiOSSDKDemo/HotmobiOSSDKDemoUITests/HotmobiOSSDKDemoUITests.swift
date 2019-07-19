//
//  HotmobiOSSDKDemoUITests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Paul Cheung on 18/2/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import XCTest

class HotmobiOSSDKDemoUITests: XCTestCase {

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

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

//Banner Test
extension HotmobiOSSDKDemoUITests {
    func testInAppBrowser(){
//        let app = XCUIApplication()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["In App"]/*[[".cells.staticTexts[\"In App\"]",".staticTexts[\"In App\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        let image = app.scrollViews.otherElements.webViews/*@START_MENU_TOKEN@*/.links/*[[".otherElements[\"Hotmob Image Wrapper\"].links",".links"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .image).element
//        image.tap()
//
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 3).tap()
    }
    
}
