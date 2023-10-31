//
//  BannerTests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 4/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class BannerTests: BaseTestCase {

    func testBannerSize_standard() {
        let banner = showBanner("Standard")
        checkSize(banner.otherElements["HMAdWebView"], w: screen().width, h: adResizedHeight(AdType.Standard))
    }

    func testBannerSize_maxi() {
        let banner = showBanner("Maxi")
        checkSize(banner.otherElements["HMAdWebView"], w: screen().width, h: adResizedHeight(AdType.Maxi))
    }

    func testBannerSize_lrec() {
        let banner = showBanner("LREC")
        checkSize(banner.otherElements["HMAdWebView"], w: screen().width, h: adResizedHeight(AdType.LREC))
    }

    func testBannerSize_standardOriginal() {
        let banner = showBanner("Standard Original")
        checkSize(banner.otherElements["HMAdWebView"], w: 320, h: 50)
    }
    
    func testBannerSize_maxiOriginal() {
        app.tables.staticTexts["LREC"].swipeLeft()
        let banner = showBanner("Maxi Original")
        checkSize(banner.otherElements["HMAdWebView"], w: 320, h: 100)
    }

    func testBannerSize_lrecOriginal() {
        app.tables.staticTexts["Standard Original"].swipeLeft()
        let banner = showBanner("LREC Original")
        checkSize(banner.otherElements["HMAdWebView"], w: 300, h: 250)
    }

    func testBannerSize_noAd() {
        app.tables.staticTexts["Standard Original"].swipeLeft()
        app.tables.cells.staticTexts["No Ad"].tap()
        
        let banner = app.scrollViews.otherElements["HotmobBanner"]
        if banner.waitForExistence(timeout: 5) {
            XCTFail()
        }
    }
    
    func testBannerCloseButton() {
        let banner = showBanner("LREC")
        let closeButton = banner.otherElements["HotmobCloseButton"]
        if !closeButton.exists {
            XCTFail()
        }
        closeButton.tap()
        delay(2)
        if banner.exists {
            XCTFail()
        }
    }
    
    func testBannerCloseCountdown() {
        let banner = showBanner("Standard")
        let closeButton = banner.otherElements["HotmobCloseButton"]
        let closeCountdown = closeButton.staticTexts["HotmobCloseCountdown"]
        if !closeCountdown.exists {
            XCTFail()
        }
        closeCountdown.tap()
        delay(2)
        if !banner.exists {
            XCTFail()
        }
        delay(5)
        if !closeButton.exists {
            XCTFail()
        }
        closeButton.tap()
        delay(2)
        if banner.exists {
            XCTFail()
        }
    }
    
    func testBannerCloseCountdownAutoPause() {
        let banner = showBanner("Standard")
        let closeButton = banner.otherElements["HotmobCloseButton"]
        let closeCountdown = closeButton.staticTexts["HotmobCloseCountdown"]
        if !closeCountdown.exists {
            XCTFail()
        }
        delay(1)
        banner.swipeUp()
        delay(4)
        app.scrollViews["ScrollView"].swipeDown()
        if !closeCountdown.exists {
            XCTFail()
        }
    }
    
    func testBannerNoCloseButton() {
        let banner = showBanner("Maxi")
        let closeButton = banner.otherElements["HotmobCloseButton"]
        if closeButton.exists {
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
    
    func checkSize(_ view: XCUIElement, w: CGFloat, h: CGFloat) {
        let viewW = view.frame.size.width
        let viewH = view.frame.size.height
        
        XCTAssertEqual(viewW, w)
        XCTAssertEqual(viewH, h)
    }

}
