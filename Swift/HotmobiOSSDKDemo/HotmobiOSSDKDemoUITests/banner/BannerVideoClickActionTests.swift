//
//  BannerVideoClickActionTests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 10/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class BannerVideoClickActionTests: BaseTestCase {
    
    func testExternal() {
        goToVideoBannerPage()
        let _ = showBanner("External")
        app.otherElements["HMVideoLanding"].tap()
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        if !safari.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }
    
    func testAppStore() {
        goToVideoBannerPage()
        let _ = showBanner("App Store")
        app.otherElements["HMVideoLanding"].tap()
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
    
    func testInternal() {
        goToVideoBannerPage()
        app.tables.staticTexts["External"].swipeLeft()
        delay(3)
        let _ = showBanner("Internal")
        app.otherElements["HMVideoLanding"].tap()
        
        if !app.staticTexts["InternalLink URL: \n new"].waitForExistence(timeout: 5) {
            XCTFail()
        }
    }
    
    func testUniversalLink() {
        goToVideoBannerPage()
        app.tables.staticTexts["External"].swipeLeft()
        let _ = showBanner("Universal Link")
        app.otherElements["HMVideoLanding"].tap()
        
        let fb = XCUIApplication(bundleIdentifier: "com.facebook.Facebook")
        if !fb.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }

    func goToVideoBannerPage() {
        app.navigationBars["HTML Banner"].children(matching: .button).element(boundBy: 0).tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Banner")/*[[".tables.containing(.other, identifier:\"Other\")",".tables.containing(.other, identifier:\"Video Interstitial\")",".tables.containing(.other, identifier:\"HTML Interstitial\")",".tables.containing(.other, identifier:\"Video Banner\")",".tables.containing(.other, identifier:\"Banner\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 1).tap()
    }
    
    func showBanner(_ button: String) -> XCUIElement {
        let tableViewCell = app.tables.cells
        tableViewCell.staticTexts[button].tap()
        
        let banner = app.scrollViews.otherElements["HotmobVideoBanner"]
        if !banner.waitForExistence(timeout: 10) {
            XCTFail()
        }
        return banner
    }
}
