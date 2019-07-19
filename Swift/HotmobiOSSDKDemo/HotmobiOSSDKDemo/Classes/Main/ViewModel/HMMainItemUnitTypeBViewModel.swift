//
//  HMMainItemUnitTypeBViewModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import RxSwift

struct HMMainItemUnitTypeBViewModel: HMBaseViewModel {
    
    var id: Variable<String?> = Variable("")
    var title: Variable<String?> = Variable("")
    var display: Variable<Bool> = Variable(false)
    var adCode: Variable<String?> = Variable("")

    
    init(id: String, title: String, display: Bool, adCode: String) {
        self.id.value = id
        self.title.value = title
        self.display.value = display
        self.adCode.value = adCode
    }
    
}
