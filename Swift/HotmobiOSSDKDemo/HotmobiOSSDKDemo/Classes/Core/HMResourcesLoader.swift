//
//  HMResourcesLoader.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation

public class HMResourcesLoader {
    
    static func frameworkBundle() -> Bundle {
        let podBundle = Bundle(for: HMMainViewController.self)
        return podBundle
    }
}
