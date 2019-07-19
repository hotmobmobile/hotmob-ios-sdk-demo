//
//  HMMainItemUnitTypeAViewModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import RxSwift

struct HMMainItemUnitTypeAViewModel: HMBaseViewModel {
    
    var id: Variable<String?> = Variable("")
    var title: Variable<String?> = Variable("")
    var display: Variable<Bool> = Variable(false)

    
    init(id: String, title: String, display: Bool) {
        self.id.value = id
        self.title.value = title
        self.display.value = display
    }

}
