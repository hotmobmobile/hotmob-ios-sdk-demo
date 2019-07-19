//
//  HMRearCatItemModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 7/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import ObjectMapper

struct HMRearCatItemModel: Mappable  {
    
    var id: String?
    var display: Bool?
    var title: String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        display         <- map["display"]
        title           <- map["title"]
    }
}
