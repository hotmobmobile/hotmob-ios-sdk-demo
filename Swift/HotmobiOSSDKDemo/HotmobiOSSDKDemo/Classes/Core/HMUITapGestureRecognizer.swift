//
//  HMUITapGestureRecognizer.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMUITapGestureRecognizer: UITapGestureRecognizer {
    var model: HMBaseViewModel? = nil
    var key: String? = nil
    
    static func removeAllTapGesture(view: UIView) {
        if let gestures = view.gestureRecognizers {
            for g in gestures {
                view.removeGestureRecognizer(g)
            }
        }
    }
}

protocol HMUIViewTapDelegate: NSObjectProtocol {
    func viewDidTap(gesture: HMUITapGestureRecognizer) -> Void
}

