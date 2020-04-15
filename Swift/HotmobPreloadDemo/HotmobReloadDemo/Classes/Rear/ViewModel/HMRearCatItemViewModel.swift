//
//  HMRearCatItemViewModel.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 8/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import RxSwift

struct HMRearCatItemViewModel: HMBaseViewModel {
    
    var id: Variable<String?> = Variable("")
    var display: Variable<Bool> = Variable(false)
    var title: Variable<String?> = Variable("")
    
    var model: HMRearCatItemModel? {
        didSet {
            self.setupData(model: model!)
        }
    }
    
    init(model: HMRearCatItemModel) {
        self.model = model
        self.setupData(model: model)
    }
    
    private func setupData(model: HMRearCatItemModel) {
        self.id.value = model.id ?? ""
        self.display.value = model.display ?? false
        self.title.value = model.title ?? ""
    }
}
