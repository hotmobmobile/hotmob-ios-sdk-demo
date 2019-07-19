//
//  HMHomeMenuModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import ObjectMapper

struct HMMainMenuModel: Mappable  {
    
    var id: String?
    var displayType: String?
    var items: [Any]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        displayType     <- map["displayType"]
        items           <- map["catItems"]
    }
}
