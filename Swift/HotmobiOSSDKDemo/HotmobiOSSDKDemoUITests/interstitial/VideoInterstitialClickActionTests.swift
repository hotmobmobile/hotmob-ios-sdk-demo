//
//  VideoInterstitialClickActionTests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 12/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class VideoInterstitialClickActionTests: BaseTestCase {
        
    func testExternal() {
        goToVideoInterstitialPage()
        let interstitial = showInterstitial("External")
        interstitial.staticTexts["Out App"].tap()
        if !app.staticTexts["Confirm to open Safari?"].waitForExistence(timeout: 5) {
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
    }
    
    func testAppStore() {
        goToVideoInterstitialPage()
        let interstitial = showInterstitial("App Store")
        interstitial.staticTexts["App Store"].tap()
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        if !safari.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
        delay(4)
        safari.buttons["Open"].tap()
        let appStore = XCUIApplication(bundleIdentifier: "com.apple.AppStore")
        if !appStore.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }
    
    // Xcode may failed
    func testInternal() {
        goToVideoInterstitialPage()
        app.tables.staticTexts["External"].gentleSwipe(.left)
        delay(1)
        app.tables.staticTexts["SMS"].gentleSwipe(.left)
        let interstitial = showInterstitial("Internal")
        interstitial.staticTexts["Internal"].tap()

        if !app.staticTexts["InternalLink URL: \n new"].waitForExistence(timeout: 5) {
            XCTFail()
        }
    }
    
    // Xcode may failed
    func testUniversalLink() {
        goToVideoInterstitialPage()
        app.tables.staticTexts["Dial"].gentleSwipe(.left)
        app.tables.staticTexts["Youtube"].gentleSwipe(.left)
        let interstitial = showInterstitial("Universal Link")
        interstitial.staticTexts["Universal"].tap()
        
        let fb = XCUIApplication(bundleIdentifier: "com.facebook.Facebook")
        if !fb.wait(for: .runningForeground, timeout: 10) {
            XCTFail()
        }
    }

    func goToVideoInterstitialPage() {
        app.navigationBars["HTML Banner"].buttons["reveal icon"].tap()
        app.tables.containing(.other, identifier:"Banner").children(matching: .cell).element(boundBy: 3).staticTexts["showcase"].tap()
    }
    
    func showInterstitial(_ button: String) -> XCUIElement {
        let tableViewCell = app.tables.cells
        tableViewCell.staticTexts[button].tap()
        
        let interstitial = app.otherElements["HotmobVideoInterstitial"]
        if !interstitial.waitForExistence(timeout: 10) {
            XCTFail()
        }
        return interstitial
    }

}
