//
//  BaseTestCase.swift
//  HotmobiOSSDKDemoUITests
//
//  Created by Ken Wong on 4/3/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import XCTest

class BaseTestCase: XCTestCase {
    var app: XCUIApplication!
    
    enum AdType: String {
        case Standard
        case Maxi
        case LREC
        case Video
        case InterstitialStandard
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        self.app = XCUIApplication()
        self.app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 10) {
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate,
                    evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                print("%s not found!", element.title)
                XCTFail()
            }else{
                print("%s found.", element.title)
            }
        }
    }
    
    func delay(_ second: Double) {
        let sec = TimeInterval.init(exactly: second)
        let smallDelay = Date(timeIntervalSinceNow: sec ?? 1)
        RunLoop.main.run(until: smallDelay)
    }
    
    func screen() -> CGSize {
        return app.frame.size
    }
    
    
    
    func adResizedHeight(_ type: AdType) -> CGFloat {
        switch (type) {
        case .Standard:
            return (screen().width == 414) ? 64.6875 : 58.59375
        case .Maxi:
            return (screen().width == 414) ? 129.375 : 117.1875
        case .LREC:
            return (screen().width == 414) ? 345 : 312.5
        case .Video:
            return (screen().width == 414) ? 232.875 : 210.9375
        case .InterstitialStandard:
            return (screen().width == 414) ? 595.125 : 539.0625
        }
    }

}

extension XCUIElement {
    enum Direction: Int {
        case up, down, left, right
    }

    func gentleSwipe(_ direction: Direction) {
        let distance = 6
        var dx = 0, dy = 0
        switch direction {
        case .up:
            dy = -distance
        case .down:
            dy = distance
        case .left:
            dx = -distance
        case .right:
            dx = distance
        }
        let start = self.coordinate(withNormalizedOffset: CGVector(dx:0, dy:0))
        let finish = self.coordinate(withNormalizedOffset: CGVector(dx:dx, dy:dy))
        start.press(forDuration: 0, thenDragTo: finish)
    }
}
