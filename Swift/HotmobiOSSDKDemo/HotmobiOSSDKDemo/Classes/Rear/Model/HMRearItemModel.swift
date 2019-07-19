//
//  HMRearItemModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 7/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import ObjectMapper

struct HMRearItemModel: Mappable  {
    
    var id: String?
    var displayType: String?
    var displayName: String?
    var catItems: [NSDictionary]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        displayType     <- map["displayType"]
        displayName     <- map["displayName"]
        catItems           <- map["catItems"]
    }
}
