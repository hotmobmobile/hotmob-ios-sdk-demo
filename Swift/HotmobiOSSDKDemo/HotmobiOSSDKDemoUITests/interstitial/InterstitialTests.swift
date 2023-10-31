//
//  InterstitialTests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 6/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class InterstitialTests: BaseTestCase {
    
    func testInterstitialStandard() {
        goToInterstitialPage()
        let interstitial = showInterstitial("Standard")
        checkSize(interstitial, w: screen().width, h: adResizedHeight(AdType.InterstitialStandard))
    }
    
    func testInterstitialLREC() {
        goToInterstitialPage()
        let interstitial = showInterstitial("LREC")
        checkSize(interstitial, w: screen().width, h: adResizedHeight(AdType.LREC))
    }
    
    func testInterstitialStandardOriginal() {
        goToInterstitialPage()
        let interstitial = showInterstitial("Standard_Original")
        checkSize(interstitial, w: 320, h: 460)
    }
    
    func testInterstitialLRECOriginal() {
        goToInterstitialPage()
        let interstitial = showInterstitial("LREC_Original")
        checkSize(interstitial, w: 300, h: 250)
    }

    func goToInterstitialPage() {
        app.navigationBars["HTML Banner"].buttons["reveal icon"].tap()
        app.tables.containing(.other, identifier:"Banner").children(matching: .cell).element(boundBy: 2).staticTexts["showcase"].tap()
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
    
    func checkSize(_ view: XCUIElement, w: CGFloat, h: CGFloat) {
        let viewW = view.frame.size.width
        let viewH = view.frame.size.height
        
        XCTAssertEqual(viewW, w)
        XCTAssertEqual(viewH, h)
    }

}
