//
//  BannerVideoTests.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 10/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class BannerVideoTests: BaseTestCase {

    func testBannerSize() {
        goToVideoBannerPage()
        let banner = showBanner("16:9 video")
        checkSize(banner, w: screen().width, h: adResizedHeight(AdType.Video))
    }
    
    func testButtonHideWithOverlay() {
        goToVideoBannerPage()
        let banner = showBanner("Button Hide with Overlay")
        delay(2)
        if app.otherElements["HotmobAdPlayButton"].exists {
            XCTFail()
        }
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == false)
        XCTAssert(app.otherElements["HotmobAdPauseButton"].exists == false)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == false)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == false)
        XCTAssert(app.progressIndicators["HotmobVideoProgressBar"].exists == false)
        banner.tap()
        if !app.otherElements["HotmobAdPauseButton"].waitForExistence(timeout: 3) {
            XCTFail()
        }
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
        XCTAssert(app.progressIndicators["HotmobVideoProgressBar"].exists == true)
        delay(3)
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == false)
        XCTAssert(app.otherElements["HotmobAdPauseButton"].exists == false)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == false)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == false)
        XCTAssert(app.progressIndicators["HotmobVideoProgressBar"].exists == false)
    }
    
    func testDisableAutoplay() {
        goToVideoBannerPage()
        let _ = showBanner("Disable Autoplay")
        delay(2)
        XCTAssert(app.otherElements["HotmobVideoOverlayView"].exists == true)
        XCTAssert(app.otherElements["HotmobAdPlayButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
        delay(5)
        XCTAssert(app.otherElements["HotmobVideoOverlayView"].exists == true)
        XCTAssert(app.otherElements["HotmobAdPlayButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
    }
    
    func testButtonHideWithDisableAutoplay() {
        goToVideoBannerPage()
        let banner = showBanner("Button Hide with Disable Autoplay")
        delay(2)
        XCTAssert(app.otherElements["HotmobAdPlayButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
        app.otherElements["HotmobAdPlayButton"].tap()
        delay(5)
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == false)
        XCTAssert(app.otherElements["HotmobAdPauseButton"].exists == false)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == false)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == false)
        banner.tap()
        if !app.otherElements["HotmobAdPauseButton"].waitForExistence(timeout: 3) {
            XCTFail()
        }
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
    }
    
    func testInitialisation() {
        goToVideoBannerPage()
        let _ = showBanner("In App")
        if !app.images["sound_off"].waitForExistence(timeout: 5) {
            XCTFail()
        }
    }
    
    func testCompletion() {
        goToVideoBannerPage()
        let _ = showBanner("In App")
        if !app.images["sound_off"].waitForExistence(timeout: 5) {
            XCTFail()
        }
        app.otherElements["HotmobAdAudioButton"].tap()
        XCTAssert(app.images["sound_on"].exists == true)
        delay(28)
        if !app.images["sound_off"].waitForExistence(timeout: 10) {
            XCTFail()
        }
        XCTAssert(app.otherElements["HotmobVideoOverlayView"].exists == true)
        delay(5)
        XCTAssert(app.otherElements["HotmobVideoOverlayView"].exists == true)
    }
    
    func testOverlayViewControl() {
        goToVideoBannerPage()
        let banner = showBanner("In App")
        delay(2)
        banner.tap()
        if !app.otherElements["HotmobVideoOverlayView"].waitForExistence(timeout: 5) {
            XCTFail()
        }
        XCTAssert(app.otherElements["HotmobAdPauseButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
        delay(1)
        banner.tap()
        app.otherElements["HotmobAdPauseButton"].tap()
        XCTAssert(app.otherElements["HotmobAdPauseButton"].exists == false)
        XCTAssert(app.otherElements["HotmobAdPlayButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
        delay(5)
        XCTAssert(app.otherElements["HotmobVideoOverlayView"].exists == true)
        app.otherElements["HotmobAdPlayButton"].tap()
        XCTAssert(app.otherElements["HotmobAdPauseButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdPlayButton"].exists == false)
        delay(5)
        XCTAssert(app.otherElements["HotmobVideoOverlayView"].exists == false)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
        delay(20)
        if !app.otherElements["HotmobVideoOverlayView"].waitForExistence(timeout: 10) {
            XCTFail()
        }
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdPlayButton"].exists == false)
        XCTAssert(app.otherElements["HotmobAdPauseButton"].exists == false)
        app.otherElements["HotmobAdReplayButton"].tap()
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdPauseButton"].exists == true)
        XCTAssert(app.otherElements["HotmobAdPlayButton"].exists == false)
    }
    
    func testNoAction() {
        goToVideoBannerPage()
        app.tables.staticTexts["App Store"].swipeLeft()
        let _ = showBanner("No Action")
        delay(2)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == false)
    }
    
    func testCustomLandingText() {
        goToVideoBannerPage()
        let _ = showBanner("External")
        delay(2)
        XCTAssert(app.staticTexts["External"].exists == true)
    }
    
    func testJPVideo() {
        goToVideoBannerPage()
        app.buttons["HK"].tap()
        let banner = showBanner("In App")
        delay(2)
        XCTAssert(app.staticTexts["PR"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
        XCTAssert(app.images["sound_off"].exists == true)
        banner.tap()
        delay(1)
        XCTAssert(app.images["sound_on"].exists == true)
        XCTAssert(app.otherElements["HotmobVideoOverlayView"].exists == false)
        delay(20)
        if !app.otherElements["HotmobVideoOverlayView"].waitForExistence(timeout: 10) {
            XCTFail()
        }
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == false)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == false)
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == true)
        XCTAssert(app.staticTexts["PR"].exists == true)
        XCTAssert(app.staticTexts["Landing 2"].exists == true)
        app.otherElements["HotmobAdReplayButton"].tap()
        delay(2)
        XCTAssert(app.images["sound_off"].exists == true)
        XCTAssert(app.otherElements["HotmobAdAudioButton"].exists == true)
        XCTAssert(app.otherElements["HMVideoLanding"].exists == true)
        XCTAssert(app.otherElements["HotmobAdReplayButton"].exists == false)
        XCTAssert(app.staticTexts["PR"].exists == true)
        XCTAssert(app.staticTexts["Landing 2"].exists == false)
        XCTAssert(app.otherElements["HotmobVideoOverlayView"].exists == false)
    }
    
    func testJPVideoNoCenterLanding() {
        goToVideoBannerPage()
        app.buttons["HK"].tap()
        let _ = showBanner("App Store")
        XCTAssert(app.staticTexts["PR"].exists == false)
        delay(25)
        if !app.otherElements["HotmobVideoOverlayView"].waitForExistence(timeout: 10) {
            XCTFail()
        }
        XCTAssert(app.otherElements["HMVideoLanding2"].exists == false)
        XCTAssert(app.staticTexts["PR"].exists == false)
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
    
    func checkSize(_ view: XCUIElement, w: CGFloat, h: CGFloat) {
        let viewW = view.frame.size.width
        let viewH = view.frame.size.height
        
        XCTAssertEqual(viewW, w)
        XCTAssertEqual(viewH, h)
    }

}
