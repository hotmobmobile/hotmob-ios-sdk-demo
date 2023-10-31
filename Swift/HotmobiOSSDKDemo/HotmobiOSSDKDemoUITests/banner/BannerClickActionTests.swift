//
//  BannerClickActionTests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 5/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class BannerClickActionTests: BaseTestCase {
    
    func testExternal() {
        let banner = showBanner("External")
        banner.tap()
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        if !safari.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }
    
    func testAppStore() {
        let banner = showBanner("App Store")
        banner.tap()
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
//        safari.buttons["Open"].tap()
        let appStore = XCUIApplication(bundleIdentifier: "com.apple.AppStore")
        if !appStore.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }

    // Assume Safari must work
    func testVideo() {
        app.tables.staticTexts["External"].swipeLeft()
        let banner = showBanner("Video")
        banner.tap()
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        if !safari.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }
    
    func testInternal() {
        app.tables.staticTexts["External"].swipeLeft()
        let banner = showBanner("Internal")
        banner.tap()
        
        if !app.staticTexts["InternalLink URL: \n new"].waitForExistence(timeout: 5) {
            XCTFail()
        }
    }
    
    func testUniversalLink() {
        app.tables.staticTexts["Dial"].swipeLeft()
        app.tables.staticTexts["Youtube"].swipeLeft()
        let banner = showBanner("Universal Link")
        banner.tap()
        
        let fb = XCUIApplication(bundleIdentifier: "com.facebook.Facebook")
        if !fb.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }
    
    func showBanner(_ button: String) -> XCUIElement {
        let tableViewCell = app.tables.cells
        tableViewCell.staticTexts[button].tap()
        
        let banner = app.scrollViews.otherElements["HotmobBanner"]
        if !banner.waitForExistence(timeout: 10) {
            XCTFail()
        }
        return banner
    }

}
