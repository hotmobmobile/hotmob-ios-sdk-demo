//
//  HMMainItemUnitTypeAViewModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct HMMainItemUnitTypeAViewModel: HMBaseViewModel {
    
    var id: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var title: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var display: BehaviorRelay<Bool> = BehaviorRelay(value: false)

    
    init(id: String, title: String, display: Bool) {
        self.id.accept(id)
        self.title.accept(title)
        self.display.accept(display)
    }

}
