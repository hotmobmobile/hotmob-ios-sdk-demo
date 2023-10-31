//
//  BannerMRAIDTests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 9/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class BannerMRAIDTests: BaseTestCase {
    
    func testResize() {
        let banner = showBanner("Celtra Resize")
        checkSize(banner.otherElements["HMAdWebView"], w: screen().width, h: adResizedHeight(AdType.Standard))
        banner.tap()
        checkSize(banner.otherElements["HMAdWebView"], w: screen().width, h: adResizedHeight(AdType.Maxi))
        app.otherElements["HMCloseArea"].tap()
        checkSize(banner.otherElements["HMAdWebView"], w: screen().width, h: adResizedHeight(AdType.Standard))
    }
    
    func testResizeOriginal() {
        app.tables.staticTexts["Celtra"].gentleSwipe(.left)
        let banner = showBanner("Celtra Resize Original")
        checkSize(banner.otherElements["HMAdWebView"], w: 320, h: 50)
        banner.tap()
        checkSize(banner.otherElements["HMAdWebView"], w: 320, h: 100)
        app.otherElements["HMCloseArea"].tap()
        checkSize(banner.otherElements["HMAdWebView"], w: 320, h: 50)
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
