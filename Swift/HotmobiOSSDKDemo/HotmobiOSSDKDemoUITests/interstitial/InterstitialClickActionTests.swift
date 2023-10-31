//
//  InterstitialClickActionTests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 6/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class InterstitialClickActionTests: BaseTestCase {
        
    func testExternal() {
        goToInterstitialPage()
        let interstitial = showInterstitial("External")
        interstitial.tap()
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        if !safari.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }
    
    func testAppStore() {
        goToInterstitialPage()
        let interstitial = showInterstitial("App Store")
        interstitial.tap()
        if !app.staticTexts["Confirm to open iTune Store?"].waitForExistence(timeout: 5) {
            XCTFail()
        }
        if !app.buttons["Cancel"].exists {
            XCTFail()
        }
        app.alerts.element.buttons["OK"].tap()
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        if !safari.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
        delay(4)
        let appStore = XCUIApplication(bundleIdentifier: "com.apple.AppStore")
        if !appStore.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }

    // Assume Safari must work
    // Xcode may failed
    func testVideo() {
        goToInterstitialPage()
        app.tables.staticTexts["External"].gentleSwipe(.left)
        let interstitial = showInterstitial("Video")
        interstitial.tap()
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        if !safari.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }
    
    // Xcode may failed
    func testInternal() {
        goToInterstitialPage()
        app.tables.staticTexts["External"].gentleSwipe(.left)
        delay(1)
        let interstitial = showInterstitial("Internal")
        interstitial.tap()

        if !app.staticTexts["InternalLink URL: \n new"].waitForExistence(timeout: 5) {
            XCTFail()
        }
    }
    
    // Xcode may failed
    func testUniversalLink() {
        goToInterstitialPage()
        app.tables.staticTexts["External"].gentleSwipe(.left)
        let interstitial = showInterstitial("Universal Link")
        interstitial.tap()
        
        let fb = XCUIApplication(bundleIdentifier: "com.facebook.Facebook")
        if !fb.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }
    
    // Failed - Cannot verify Toast Message
//    func testNoAd() {
//        goToInterstitialPage()
//        app.tables.staticTexts["LREC"].swipeLeft()
//        app.tables.cells.staticTexts["No Ad"].tap()
//        if !app.otherElements["No Ad Returned"].waitForExistence(timeout: 15) {
//            XCTFail()
//        }
//    }

    func goToInterstitialPage() {
        app.navigationBars["HTML Banner"].children(matching: .button).element(boundBy: 0).tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Banner")/*[[".tables.containing(.other, identifier:\"Other\")",".tables.containing(.other, identifier:\"Video Interstitial\")",".tables.containing(.other, identifier:\"HTML Interstitial\")",".tables.containing(.other, identifier:\"Video Banner\")",".tables.containing(.other, identifier:\"Banner\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 2).tap()
        delay(1)
    }
    
    func showInterstitial(_ button: String) -> XCUIElement {
        let tableViewCell = app.tables.cells
        tableViewCell.staticTexts[button].tap()
        
        let interstitial = app.otherElements["HMAdWebView"]
        if !interstitial.waitForExistence(timeout: 10) {
            XCTFail()
        }
        return interstitial
    }

}
