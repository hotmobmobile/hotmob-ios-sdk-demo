//
//  HMMainItemUnitTypeBViewModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct HMMainItemUnitTypeBViewModel: HMBaseViewModel {
    
    var id: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var title: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var display: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var adCode: BehaviorRelay<String?> = BehaviorRelay(value: "")

    
    init(id: String, title: String, display: Bool, adCode: String) {
        self.id.accept(id)
        self.title.accept(title)
        self.display.accept(display)
        self.adCode.accept(adCode)
    }
    
}
