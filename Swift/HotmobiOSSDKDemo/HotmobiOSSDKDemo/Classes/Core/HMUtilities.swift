//
//  HMUtilities.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 18/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import UIKit

class HMUtilities {

    // MARK: - Custom methods
    static func objectToString(object: Any) -> String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        let jsonString = String(data: jsonData!, encoding: String.Encoding.utf8)
        return jsonString
    }
    
    static func SYSTEM_VERSION_EQUAL_TO(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedSame
    }
    
    static func SYSTEM_VERSION_GREATER_THAN(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedDescending
    }
    
    static func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedAscending
    }
    
    static func SYSTEM_VERSION_LESS_THAN(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedAscending
    }
    
    static func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedDescending
    }

}
