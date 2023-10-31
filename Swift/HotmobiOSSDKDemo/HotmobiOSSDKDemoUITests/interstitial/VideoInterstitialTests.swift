//
//  VideoInterstitialTests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 10/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class VideoInterstitialTests: BaseTestCase {
    
    // Non-iPhoneX devices only
    // UI test cannot get safe area for calculation
    func testInterstitialLayout() {
        goToVideoInterstitialPage()
        let interstitial = showInterstitial("16:9 video")
        checkLayout(interstitial)
        XCUIDevice.shared.orientation = .landscapeLeft
        delay(1)
        checkLandscapeLayout(interstitial)
        XCUIDevice.shared.orientation = .portrait
        delay(2)
        checkLayout(interstitial)
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
    
    func checkLayout(_ view: XCUIElement) {
        let webview = view.otherElements["HMAdWebView"]
        let wvW = webview.frame.size.width
        let wvH = webview.frame.size.height
        
        XCTAssertEqual(wvW, screen().width)
        XCTAssertEqual(wvH, screen().width)
        
        let videoview = view.otherElements["HotmobVideoAdView"]
        let vvW = videoview.frame.size.width
        let vvH = videoview.frame.size.height
        
        XCTAssertEqual(vvW, screen().width)
        XCTAssertEqual(vvH, screen().height - screen().width)
    }

    func checkLandscapeLayout(_ view: XCUIElement) {
        if view.otherElements["HMAdWebView"].exists {
            XCTFail()
        }
        
        let videoview = view.otherElements["HotmobVideoAdView"]
        let vvW = videoview.frame.size.width.rounded()    // unexpected N.000000000006
        let vvH = videoview.frame.size.height
        
        XCTAssertEqual(vvW, screen().width)
        XCTAssertEqual(vvH, screen().height)
    }
}
