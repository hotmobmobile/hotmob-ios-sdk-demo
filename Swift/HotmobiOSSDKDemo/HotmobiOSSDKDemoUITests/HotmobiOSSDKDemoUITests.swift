//
//  HotmobiOSSDKDemoUITests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Paul Cheung on 18/2/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import XCTest

class HotmobiOSSDKDemoUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.

        self.app = XCUIApplication()
        self.app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

// MARK: - Banner Test
extension HotmobiOSSDKDemoUITests {
    func testHTMLBannerDisplay(){
        let tableViewCell = app.tables.cells
        tableViewCell.staticTexts["In App"].tap()
        
        let webView = app.scrollViews.otherElements["HMAdWebView"]
        self.waitForElementToAppear(webView)
        
        webView.tap()
        self.delay(5)
        
       self.closeInAppBrowser()
    }
    
//    func testVideoBannerDisplay(){
//        self.app.navigationBars["HTML Banner"].buttons["reveal icon"].tap()
//        self.app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Video Banner")/*[[".tables.containing(.other, identifier:\"Other\")",".tables.containing(.other, identifier:\"Video Interstitial\")",".tables.containing(.other, identifier:\"HTML Interstitial\")",".tables.containing(.other, identifier:\"Video Banner\")",".tables.containing(.other, identifier:\"Banner\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 1).staticTexts["showcase"].tap()
//        self.app.tables/*@START_MENU_TOKEN@*/.staticTexts["In App"]/*[[".cells.staticTexts[\"In App\"]",".staticTexts[\"In App\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        self.delay(3)
//    }
//
//    func testVideoBannerPause(){
//        self.testVideoBannerDisplay()
//        self.videoViewTap()
//        self.videoPauseButtonClick()
//
//        self.delay(3)
//    }
//
//    func testVideoBannerPlay(){
//        self.testVideoBannerPause()
//        self.videoPlayButtonClick()
//
//        self.delay(5)
//    }
//
//    func testVideoBannerAudioOn(){
//        // Off->On
//        self.testVideoBannerDisplay()
//
//        self.videoAudioButtonClick()
//        self.delay(8)
//    }
//
//    func testVideoBannerAudioOff(){
//        // Off->On->Off
//        self.testVideoBannerDisplay()
//        self.videoAudioButtonClick()
//        self.delay(5)
//        self.videoAudioButtonClick()
//        self.delay(5)
//    }
    
}

// MARK: - Common function
extension HotmobiOSSDKDemoUITests {
    func closeInAppBrowser(){
        self.app.buttons["close button"].tap()
        self.delay(5)
    }
    
    func videoViewTap(){
        let videoView = app.scrollViews.otherElements["Video_Banner"]
        videoView.tap()
    }
    
    func videoPauseButtonClick(){
        let videoView = app.scrollViews.otherElements["Video_Banner"]
        
        let pause = videoView.otherElements["pause_button"]
        pause.tap()
        self.delay(5)
    }
    
    func videoPlayButtonClick(){
        let videoView = app.scrollViews.otherElements["Video_Banner"]
        
        let play = videoView.otherElements["play_button"]
        play.tap()
        self.delay(5)
    }
    
    func videoAudioButtonClick(){
        let videoView = app.scrollViews.otherElements["Video_Banner"]
        
        let audio = videoView.otherElements["audio_button"]
        audio.tap()
        self.delay(5)
    }
    
}


// MARK: - General function
extension HotmobiOSSDKDemoUITests {
    func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 10,  file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate,
                    evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }else{
                print("element found ")
            }
        }
    }
    
    func delay(_ second: Double) {
        let sec = TimeInterval.init(exactly: second)
        let smallDelay = Date(timeIntervalSinceNow: sec ?? 1)
        RunLoop.main.run(until: smallDelay)
    }

}
